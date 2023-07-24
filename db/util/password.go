package util

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

// HashPassword return the bcrypt hash of the password
func HashPassword(password string) (string, error) {
	hashedPasword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)

	if err != nil {
		return "", fmt.Errorf("failed to hash password: %w", err)
	}
	return string(hashedPasword), nil
}

// CheckPassword check if provided password is correct or not
func CheckPassword(password string, hashedPassword string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
}
