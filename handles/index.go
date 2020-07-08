package handles

import (
	"github.com/louisevanderlith/droxolite/context"
	"github.com/louisevanderlith/droxolite/mix"
	"html/template"
	"log"
	"net/http"
	"time"
)

func Index(tmpl *template.Template) http.HandlerFunc {
	pge := mix.PreparePage(tmpl, "Index", "./views/index.html")
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
		ctx := context.New(w, r)

		err := ctx.Serve(http.StatusOK, pge.Page(obj, ctx.GetTokenInfo(), ctx.GetToken()))

		if err != nil {
			log.Println(err)
		}
	}
}
