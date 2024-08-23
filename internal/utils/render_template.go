package utils

import (
	"html/template"
	"net/http"
)

type ResponseData struct {
	Success bool
	Error   bool
	Message string
}

func RenderTemplate(w http.ResponseWriter, path string, data ResponseData) {
	templ := template.Must(template.ParseFiles("./internal/views/" + path + ".html"))
	err := templ.Execute(w, data)
	if err != nil {
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}
