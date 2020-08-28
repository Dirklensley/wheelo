package handles

import (
	"github.com/gorilla/mux"
	"github.com/louisevanderlith/droxolite/drx"
	"github.com/louisevanderlith/kong"
	"net/http"
)

func SetupRoutes(clnt, scrt, securityUrl, authorityUrl string) http.Handler {
	tmpl, err := drx.LoadTemplate("./views")

	if err != nil {
		panic(err)
	}

	r := mux.NewRouter()
	distPath := http.FileSystem(http.Dir("dist/"))
	fs := http.FileServer(distPath)
	r.PathPrefix("/dist/").Handler(http.StripPrefix("/dist/", fs))

	scopes := map[string]bool{
		"comms.messages.create":    true,
		"leads.submission.create":  true,
		"vin.lookup.manufacturers": true,
		"vin.lookup.models":        true,
		"vin.lookup.trims":         true,
		"artifact.uploads.create":  true,
	}
	r.HandleFunc("/", kong.ClientMiddleware(http.DefaultClient, clnt, scrt, securityUrl, authorityUrl, Index(tmpl), scopes)).Methods(http.MethodGet)
	r.HandleFunc("/photos", kong.ClientMiddleware(http.DefaultClient, clnt, scrt, securityUrl, authorityUrl, Photos(tmpl), scopes)).Methods(http.MethodGet)
	r.HandleFunc("/personal", kong.ClientMiddleware(http.DefaultClient, clnt, scrt, securityUrl, authorityUrl, Personal(tmpl), scopes)).Methods(http.MethodGet)

	return r
}
