package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

func IndexPage(c *gin.Context) {
	var years []int

	for i := time.Now().Year(); i > 1941 ; i-- {
		years = append(years, i)
	}

	c.HTML(http.StatusOK, "index.html", gin.H{
		"years": years,
	})
}
