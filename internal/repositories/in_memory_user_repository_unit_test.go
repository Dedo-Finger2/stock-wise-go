package repositories_test

import (
	"testing"

	"github.com/Dedo-Finger2/stock-wise-go/internal/domain/entities"
	"github.com/Dedo-Finger2/stock-wise-go/internal/repositories"
)

func Test_InMemoryUserRepository(t *testing.T) {
	user, err := entities.NewUserEntity("valid@email.com", "1234567")
	if err != nil {
		t.Errorf("unexpected error on trying to create user: %s", err)
	}
	userRepository := repositories.NewInMemoryUserRepository()

	t.Run("it should create a new user", func(t *testing.T) {
		err = userRepository.CreateUser(user)
		if err != nil {
			t.Errorf("unexpected error on trying to create user: %s", err)
		}

		if len(userRepository.Users) < 1 {
			t.Error("expected repo.Users length to be 1 after creating a user, but got 0.")
		}
	})

	t.Run("it return an user when passing the ID", func(t *testing.T) {
		err = userRepository.CreateUser(user)
		if err != nil {
			t.Errorf("unexpected error on trying to create user: %s", err)
		}

		_, err := userRepository.GetUserByID(user.ID)
		if err != nil {
			t.Errorf("unexpected error on trying to get user by ID: %s", err)
		}
	})

	t.Run("it return an user when passing the email", func(t *testing.T) {
		err = userRepository.CreateUser(user)
		if err != nil {
			t.Errorf("unexpected error on trying to create user: %s", err)
		}

		_, err := userRepository.GetUserByEmail(user.Email)
		if err != nil {
			t.Errorf("unexpected error on trying to get user by email: %s", err)
		}
	})

}
