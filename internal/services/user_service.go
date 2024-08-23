package services

import "github.com/Dedo-Finger2/stock-wise-go/internal/repositories"

type UserService struct {
	r repositories.IUserRepository
}

func NewUserService(r repositories.IUserRepository) *UserService {
	return &UserService{r: r}
}
