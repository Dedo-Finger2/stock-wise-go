package handlers

import (
	"net/http"

	"github.com/Dedo-Finger2/stock-wise-go/internal/utils"
)

func (h *UserHandler) RegisterUser(w http.ResponseWriter, r *http.Request) {
	data := utils.ResponseData{}

	email := r.FormValue("email")
	if email == "" {
		data.Error = true
		data.Message = "Email is required."
		utils.RenderTemplate(w, "register-user", data)
		return
	}

	password := r.FormValue("password")
	if password == "" {
		data.Error = true
		data.Message = "Password is required."
		utils.RenderTemplate(w, "register-user", data)
		return
	}
	if len(password) < 6 {
		data.Error = true
		data.Message = "Password is too short. It must be greater than 6 characters."
		utils.RenderTemplate(w, "register-user", data)
		return
	}

	err := h.s.RegisterUser(email, password)
	if err != nil {
		data.Error = true
		data.Message = err.Error()
		utils.RenderTemplate(w, "register-user", data)
		return
	}

	data.Success = true
	data.Message = "Success."
	w.Header().Set("HX-Redirect", "/login")
	w.WriteHeader(http.StatusSeeOther)
}
