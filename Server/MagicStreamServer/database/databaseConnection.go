package database

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"log"
	"os"
    "context"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/v2/mongo"
	"go.mongodb.org/mongo-driver/v2/mongo/options"
)

func Connect() *mongo.Client {

	err := godotenv.Load(".env")

	if err != nil {
		log.Println("Warning: unable to find .env file")
	}

	MongoDb := os.Getenv("MONGODB_URI")

	if MongoDb == "" {
		log.Fatal("MONGODB_URI not set!")
	}

	fmt.Println("MongoDB URI: ", MongoDb)

	caCert, err := os.ReadFile("/app/certs/global-bundle.pem")
	if err != nil {
		log.Fatal("Failed to read CA file:", err)
	}

	certPool := x509.NewCertPool()

	if ok := certPool.AppendCertsFromPEM(caCert); !ok {
		log.Fatal("Failed to append CA certificate")
	}

	tlsConfig := &tls.Config{
		RootCAs: certPool,
	}

	clientOptions := options.Client().
		ApplyURI(MongoDb).
		SetTLSConfig(tlsConfig)

	client, err := mongo.Connect(clientOptions)

	if err != nil {
    log.Fatal("Failed to create Mongo client:", err)
    }

	err = client.Ping(context.Background(), nil)
	if err != nil {
    log.Fatal("Failed to ping DocumentDB:", err)
	}

	log.Println("Connected successfully to DocumentDB")

	return client
	}

//var Client *mongo.Client = DBInstance()

func OpenCollection(collectionName string, client *mongo.Client) *mongo.Collection {

	err := godotenv.Load(".env")
	if err != nil {
		log.Println("Warning: unable to find .env file")
	}

	databaseName := os.Getenv("DATABASE_NAME")

	fmt.Println("DATABASE_NAME: ", "MongoDB connected to DocumentDB")

	collection := client.Database(databaseName).Collection(collectionName)

	if collection == nil {
		return nil
	}
	return collection

}
