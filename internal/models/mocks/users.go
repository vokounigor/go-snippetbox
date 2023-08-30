package mocks

import (
	"snippetbox/internal/models"
	"time"
)

type UserModel struct{}

func (m *UserModel) Insert(name, email, password string) error {
	switch email {
	case "test@example.com":
		return models.ErrDuplicateEmail
	default:
		return nil
	}
}

func (m *UserModel) Authenticate(email, password string) (int, error) {
	if email == "alice@example.com" && password == "pa$$word" {
		return 1, nil
	}

	return 0, models.ErrInvalidCredentials
}

func (m *UserModel) Exists(id int) (bool, error) {
	switch id {
	case 1:
		return true, nil
	default:
		return false, nil
	}
}

func (m *UserModel) Get(id int) (*models.User, error) {
	user := &models.User{
		Name:    "Alice Jones",
		Email:   "alice@example.com",
		Created: time.Now(),
	}

	switch id {
	case 1:
		return user, nil
	default:
		return nil, models.ErrNoRecord
	}
}

func (m *UserModel) PasswordUpdate(id int, currentPassword string, newPassword string) error {
	if id == 1 {
		return nil
	} else {
		return models.ErrInvalidCredentials
	}
}
