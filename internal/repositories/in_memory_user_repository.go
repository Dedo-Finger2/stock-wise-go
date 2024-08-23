package repositories

import (
	"github.com/Dedo-Finger2/stock-wise-go/internal/domain/entities"
)

type InMemoryUserRepository struct {
	Users map[string]*entities.User
}

func NewInMemoryUserRepository() *InMemoryUserRepository {
	return &InMemoryUserRepository{Users: make(map[string]*entities.User)}
}

func (r *InMemoryUserRepository) CreateUser(u *entities.User) error {
	r.Users[u.ID] = u

	return nil
}

func (r *InMemoryUserRepository) GetUserByID(id string) (*entities.User, error) {
	user := r.Users[id]

	return user, nil
}

func (r *InMemoryUserRepository) GetUserByEmail(e string) (*entities.User, error) {
	for _, user := range r.Users {
		if user.Email == e {
			return user, nil
		}
	}

	return &entities.User{}, nil
}
