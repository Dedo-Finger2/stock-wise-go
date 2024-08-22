package entities

import (
	"errors"
	"net/mail"
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID        string
	Email     string
	Password  string
	CreatedAt string
}

func NewUserEntity(email, password string) (*User, error) {
	newUser := User{
		ID:        uuid.New().String(),
		Email:     email,
		Password:  password,
		CreatedAt: time.Now().Local().String(),
	}

	err := newUser.validateEmail()
	if err != nil {
		return &User{}, err
	}

	err = newUser.validatePassword()
	if err != nil {
		return &User{}, err
	}

	return &newUser, nil
}

func (e *User) validateEmail() error {
	_, err := mail.ParseAddress(e.Email)
	if err != nil {
		return err
	}

	return nil
}
func (e *User) validatePassword() error {
	if len(e.Password) < 6 {
		return errors.New("invalid password length. Must be greater than 6")
	}

	return nil
}
