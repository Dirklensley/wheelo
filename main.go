package main

import (
	"flag"
	"github.com/dirklensley/wheelo/handles"
	"github.com/louisevanderlith/droxolite/drx"
	"log"
	"net/http"
	"time"
)

func main() {
	clientId := flag.String("client", "mango.wheelo", "Client ID which will be used to verify this instance")
	clientSecrt := flag.String("secret", "secret", "Client Secret which will be used to authenticate this instance")
	securty := flag.String("security", "http://localhost:8086", "Security Provider's URL")
	authr := flag.String("authority", "http://localhost:8094", "Authority Provider's URL")

	flag.Parse()

	err := drx.UpdateTemplate(*clientId, *clientSecrt, *securty)

	if err != nil {
		panic(err)
	}

	srvr := &http.Server{
		ReadTimeout:  time.Second * 15,
		WriteTimeout: time.Second * 15,
		Addr:         ":8105",
		Handler:      handles.SetupRoutes(*clientId, *clientSecrt, *securty, *authr),
	}

	err = srvr.ListenAndServe()

	if err != nil {
		log.Println(err)
	}
}
