package routes

import (
	controller "github.com/GavinLonDigital/MagicStream/Server/MagicStreamServer/controllers"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/v2/mongo"
)

func SetupUnProtectedRoutes(router *gin.Engine, client *mongo.Client) {

	api := router.Group("/api")
	{
		api.GET("/movies", controller.GetMovies(client))
		api.POST("/register", controller.RegisterUser(client))
		api.POST("/login", controller.LoginUser(client))
		api.POST("/logout", controller.LogoutHandler(client))
		api.GET("/genres", controller.GetGenres(client))
		api.POST("/refresh", controller.RefreshTokenHandler(client))
		api.POST("/addmovie", controller.AddMovie(client))
	}
}
