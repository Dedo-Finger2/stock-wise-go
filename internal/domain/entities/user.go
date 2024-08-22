package entities

import (
	"errors"
	"net/mail"

	"github.com/google/uuid"
)

type user struct {
	ID       string
	Email    string
	Password string
}

func NewUserEntity(email, password string) (*user, error) {
	newUser := user{
		ID:       uuid.New().String(),
		Email:    email,
		Password: password,
	}

	err := newUser.validateEmail()
	if err != nil {
		return &user{}, err
	}

	err = newUser.validatePassword()
	if err != nil {
		return &user{}, err
	}

	return &newUser, nil
}

func (e *user) validateEmail() error {
	_, err := mail.ParseAddress(e.Email)
	if err != nil {
		return err
	}

	return nil
}
func (e *user) validatePassword() error {
	if len(e.Password) < 6 {
		return errors.New("invalid password length. Must be greater than 6")
	}

	return nil
}
