package handles

import (
	"github.com/gorilla/mux"
	"github.com/louisevanderlith/droxolite/drx"
	"github.com/louisevanderlith/kong/middle"
	"net/http"
)

func SetupRoutes(clnt, scrt, securityUrl, managerUrl, authorityUrl string) http.Handler {
	tmpl, err := drx.LoadTemplate("./views")

	if err != nil {
		panic(err)
	}

	r := mux.NewRouter()
	distPath := http.FileSystem(http.Dir("dist/"))
	fs := http.FileServer(distPath)
	r.PathPrefix("/dist/").Handler(http.StripPrefix("/dist/", fs))

	scopes := map[string]bool{
		"comms.messages.create":        true,
		"leads.submission.create":      true,
		"vehicle.lookup.manufacturers": true,
		"vehicle.lookup.models":        true,
		"vehicle.lookup.trims":         true,
		"artifact.uploads.create":      true,
	}

	clntIns := middle.NewClientInspector(clnt, scrt, http.DefaultClient, securityUrl, managerUrl, authorityUrl)
	r.HandleFunc("/", clntIns.Middleware(Index(tmpl), scopes)).Methods(http.MethodGet)
	r.HandleFunc("/photos", clntIns.Middleware(Photos(tmpl), scopes)).Methods(http.MethodGet)
	r.HandleFunc("/personal", clntIns.Middleware(Personal(tmpl), scopes)).Methods(http.MethodGet)

	return r
}
