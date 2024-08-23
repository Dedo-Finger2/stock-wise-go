package handlers

import "github.com/Dedo-Finger2/stock-wise-go/internal/services"

type UserHandler struct {
	s *services.UserService
}

func NewUserHandler(s *services.UserService) *UserHandler {
	return &UserHandler{s: s}
}
