package services

import (
	"github.com/Dedo-Finger2/stock-wise-go/internal/domain/entities"
	"golang.org/x/crypto/bcrypt"
)

func (s *UserService) RegisterUser(email, password string) error {
	cost := 14
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), cost)
	if err != nil {
		return err
	}

	user, err := entities.NewUserEntity(email, string(bytes))
	if err != nil {
		return err
	}

	err = s.r.CreateUser(user)
	if err != nil {
		return err
	}

	return nil
}
