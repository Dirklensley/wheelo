package handles

import (
	"github.com/gorilla/mux"
	"github.com/louisevanderlith/droxolite"
	"github.com/louisevanderlith/kong"
	"net/http"
)

func SetupRoutes(clnt, scrt, secureUrl, authUrl string) http.Handler {
	tmpl, err := droxolite.LoadTemplate("./views")

	if err != nil {
		panic(err)
	}

	r := mux.NewRouter()
	distPath := http.FileSystem(http.Dir("dist/"))
	fs := http.FileServer(distPath)
	r.PathPrefix("/dist/").Handler(http.StripPrefix("/dist/", fs))

	scopes := []string{
		"comms.messages.create",
		"theme.assets.download",
		"theme.assets.view",
		"artifact.download",
		"leads.submission.create",
		"vin.lookup.manufacturers",
		"vin.lookup.models",
		"vin.lookup.trims",
		"artifact.uploads.create",
	}
	r.HandleFunc("/", kong.ClientMiddleware(http.DefaultClient, clnt, scrt, secureUrl, authUrl, Index(tmpl), scopes...)).Methods(http.MethodGet)

	return r
}
