import boto3
import json
import os

from pymongo import MongoClient


s3 = boto3.client("s3")
secrets = boto3.client("secretsmanager")


def get_secret(name):

    response = secrets.get_secret_value(
        SecretId=name
    )

    return json.loads(response["SecretString"])


def lambda_handler(event, context):

    mongo_secret = get_secret(
        os.environ["MONGO_SECRET_NAME"]
    )

    username = mongo_secret["userdatabase"]

    password = mongo_secret["passworddatabase"] 


    client = MongoClient(
        f"mongodb://{username}:{password}@{os.environ['DOCDB_ENDPOINT']}:27017/",
        tls=True,
        tlsCAFile="/var/task/global-bundle.pem",
        replicaSet="rs0",
        retryWrites=False
    )


    db = client["magicstream"]

    movies_collection = db["movies"]


    response = s3.get_object(
        Bucket=os.environ["BUCKET"],
        Key="seed/movies.json"
    )


    movies = json.loads(
        response["Body"].read()
    )


    result = movies_collection.insert_many(movies)
    client.close()

    return {
        "inserted": len(result.inserted_ids)
    }