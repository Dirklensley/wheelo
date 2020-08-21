package handles

import (
	"github.com/louisevanderlith/droxolite/mix"
	"html/template"
	"log"
	"net/http"
	"time"
)

func Index(tmpl *template.Template) http.HandlerFunc {
	pge := mix.PreparePage("Index", tmpl, "./views/index.html")
	var years []int

	for i := time.Now().Year(); i > 1941; i-- {
		years = append(years, i)
	}

	obj := struct {
		Years []int
	}{
		Years: years,
	}
	return func(w http.ResponseWriter, r *http.Request) {
		err := mix.Write(w, pge.Create(r, obj))

		if err != nil {
			log.Println("Serve Error", err)
		}
	}
}
