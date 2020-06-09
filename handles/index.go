package handles

import (
	"github.com/louisevanderlith/droxolite/context"
	"github.com/louisevanderlith/droxolite/mix"
	"html/template"
	"log"
	"net/http"
	"time"
)

func Index(mstr *template.Template, tmpl *template.Template) http.HandlerFunc {
	var years []int

	for i := time.Now().Year(); i > 1941; i-- {
		years = append(years, i)
	}

	obj := struct {
		Years []int
		Token string
	}{
		Years: years,
	}
	return func(w http.ResponseWriter, r *http.Request) {
		ctx := context.New(w, r)

		tkn := r.Context().Value("token")

		if tkn == nil {
			http.Error(w, "no token", http.StatusUnauthorized)
			return
		}

		obj.Token = tkn.(string)
		mxr := mix.Page("index", obj, ctx.GetTokenInfo(), mstr, tmpl)

		err := ctx.Serve(http.StatusOK, mxr)

		if err != nil {
			log.Println(err)
		}
	}
}
