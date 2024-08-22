package repositories

import "github.com/Dedo-Finger2/stock-wise-go/internal/domain/entities"

type IUserRepository interface {
	CreateUser(u *entities.User) error
	GetUserByID(id string) (*entities.User, error)
	GetUserByEmail(e string) (*entities.User, error)
}
