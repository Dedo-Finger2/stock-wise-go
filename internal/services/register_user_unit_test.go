package services_test

import (
	"testing"

	"github.com/Dedo-Finger2/stock-wise-go/internal/domain/entities"
	"github.com/Dedo-Finger2/stock-wise-go/internal/repositories"
	"github.com/Dedo-Finger2/stock-wise-go/internal/services"
	"golang.org/x/crypto/bcrypt"
)

func Test_RegisterUser(t *testing.T) {
	r := repositories.NewInMemoryUserRepository()
	s := services.NewUserService(r)

	t.Run("it should create a new user", func(t *testing.T) {
		err := s.RegisterUser("validemail@gmail.com", "1234567")
		if err != nil {
			t.Errorf("failed to register a new user: %s", err)
		}
	})

	t.Run("it should be hashing the user password", func(t *testing.T) {
		err := s.RegisterUser("validemail@gmail.com", "1234567")
		if err != nil {
			t.Errorf("failed to register a new user: %s", err)
		}

		var u *entities.User

		for _, value := range r.Users {
			u = value
		}

		err = bcrypt.CompareHashAndPassword([]byte(u.Password), []byte("1234567"))
		if err != nil {
			t.Errorf("unexpected error on trying to compare hashed and original passwords: %s", err)
		}
	})

}
