package main

import (
	"flag"
	"github.com/dirklensley/wheelo/handles"
	"log"
	"net/http"
	"time"
)

func main() {
	host := flag.String("host", "http://127.0.0.1:8107", "This application's URL")
	clientId := flag.String("client", "mango.folio", "Client ID which will be used to verify this instance")
	clientSecrt := flag.String("secret", "secret", "Client Secret which will be used to authenticate this instance")
	issuer := flag.String("issuer", "http://127.0.0.1:8080/auth/realms/mango", "OIDC Provider's URL")
	theme := flag.String("theme", "http://127.0.0.1:8093", "Theme URL")
	flag.Parse()

	ends := map[string]string{
		"issuer": *issuer,
		"theme":  *theme,
	}

	srvr := &http.Server{
		ReadTimeout:  time.Second * 15,
		WriteTimeout: time.Second * 15,
		Addr:         ":8105",
		Handler:      handles.SetupRoutes(*host, *clientId, *clientSecrt, ends),
	}

	err := srvr.ListenAndServe()

	if err != nil {
		log.Println(err)
	}
}
