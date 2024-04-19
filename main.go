package main

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

func main() {

	formatter := func(gin.LogFormatterParams) string {
		return "test"
	}

	r := gin.New()
	r.Use(gin.Recovery())
	r.Use(gin.LoggerWithConfig(gin.LoggerConfig{
		Output:    gin.DefaultWriter,
		Formatter: formatter,
	}))

	fmt.Println("Starting API on port 80...")
	r.Run(":80")

}
