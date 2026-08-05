package routes

import (
	controller "github.com/GavinLonDigital/MagicStream/Server/MagicStreamServer/controllers"
	"github.com/GavinLonDigital/MagicStream/Server/MagicStreamServer/middleware"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/v2/mongo"
)

func SetupProtectedRoutes(router *gin.Engine, client *mongo.Client) {
	api := router.Group("/api")
	api.Use(middleware.AuthMiddleWare())
	api.GET("/movie/:imdb_id", controller.GetMovie(client))
	api.GET("/recommendedmovies", controller.GetRecommendedMovies(client))
	api.PATCH("/updatereview/:imdb_id", controller.AdminReviewUpdate(client))
}
