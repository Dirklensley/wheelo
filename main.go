package main

import (
	"github.com/dirklensley/wheelo/controllers"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/", controllers.IndexPage)
	router.Static("/assets", "./assets")
	router.LoadHTMLGlob("views/*")

	router.Run(":8080")
}
