package entities_test

import (
	"testing"

	"github.com/Dedo-Finger2/stock-wise-go/internal/domain/entities"
)

func Test_UserEntity(t *testing.T) {
	t.Run("it should return an error on trying to create a user with invalid email", func(t *testing.T) {
		_, err := entities.NewUserEntity("invalid", "1234567")
		if err == nil {
			t.Error("Expected to return an error when using an invalid email on user creation, but returned nil.")
		}
	})

	t.Run("it should return an error on trying to create a user with short password", func(t *testing.T) {
		_, err := entities.NewUserEntity("valid@email.com", "1")
		if err == nil {
			t.Error("Expected to return an error when using a short password on user creation, but returned nil.")
		}
	})

	t.Run("it should create a user normally", func(t *testing.T) {
		_, err := entities.NewUserEntity("valid@email.com", "1234567")
		if err != nil {
			t.Errorf("Expected to not return an error, but got one instead: %s", err)
		}
	})

	t.Run("it should be adding an UUID to the user on creation", func(t *testing.T) {
		user, err := entities.NewUserEntity("valid@email.com", "1234567")
		if err != nil {
			t.Errorf("Expected to not return an error, but got one instead: %s", err)
		}

		if user.ID == "" || len(user.ID) < 36 {
			t.Error("Invalid UUID. Invalid length or empty.")
		}
	})

	t.Run("it should be adding the current date time to the user on creation", func(t *testing.T) {
		user, err := entities.NewUserEntity("valid@email.com", "1234567")
		if err != nil {
			t.Errorf("Expected to not return an error, but got one instead: %s", err)
		}

		if user.CreatedAt == "" {
			t.Error("Expected created at to be current date, but it's empty.")
		}
	})

}
