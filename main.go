package main

import (
	"flag"
	"github.com/dirklensley/wheelo/handles"
	"github.com/louisevanderlith/droxolite"
	"github.com/louisevanderlith/kong"
	"log"
	"net/http"
	"time"
)

func main() {
	clientId := flag.String("client", "mango.www", "Client ID which will be used to verify this instance")
	clientSecrt := flag.String("secret", "secret", "Client Secret which will be used to authenticate this instance")
	securty := flag.String("security", "http://localhost:8086", "Security Provider's URL")
	authr := flag.String("authority", "http://localhost:8094", "Authority Provider's URL")

	flag.Parse()

	log.Println(*clientId)

	tkn, err := kong.FetchToken(http.DefaultClient, *securty, *clientId, *clientSecrt, "theme.assets.download", "theme.assets.view")

	if err != nil {
		panic(err)
	}

	clms, err := kong.Exchange(http.DefaultClient, tkn, *clientId, *clientSecrt, *securty+"/info")

	if err != nil {
		panic(err)
	}

	err = droxolite.UpdateTemplate(tkn, clms)

	if err != nil {
		panic(err)
	}

	srvr := &http.Server{
		ReadTimeout:  time.Second * 15,
		WriteTimeout: time.Second * 15,
		Addr:         ":8091",
		Handler:      handles.SetupRoutes(*clientId, *clientSecrt, *securty, *authr),
	}

	err = srvr.ListenAndServe()

	if err != nil {
		log.Println(err)
	}
}
