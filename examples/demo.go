// Package main demonstrates Go syntax highlighting for CoMPhy Gruvbox Theme
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"
)

// Constants and variables
const (
	APIVersion     = "v2.0.0"
	DefaultTimeout = 30 * time.Second
)

var (
	logger = log.Default()
)

// User represents a user in the system
type User struct {
	ID        int64     `json:"id"`
	Username  string    `json:"username"`
	Email     string    `json:"email"`
	Active    bool      `json:"active"`
	CreatedAt time.Time `json:"createdAt"`
}

// Validate checks if the user data is valid
func (u *User) Validate() error {
	if u.Username == "" {
		return fmt.Errorf("username is required")
	}
	if u.Email == "" {
		return fmt.Errorf("email is required")
	}
	return nil
}

// Repository defines the interface for data access
type Repository interface {
	FindByID(ctx context.Context, id int64) (*User, error)
	Create(ctx context.Context, user *User) error
}

// Service provides business logic
type Service struct {
	repo Repository
	mu   sync.RWMutex
}

// NewService creates a new service instance
func NewService(repo Repository) *Service {
	return &Service{repo: repo}
}

// GetUser retrieves a user by ID
func (s *Service) GetUser(ctx context.Context, id int64) (*User, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	user, err := s.repo.FindByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("failed to find user %d: %w", id, err)
	}
	return user, nil
}

// Handler handles HTTP requests
type Handler struct {
	service *Service
}

// GetUserHandler handles GET /users/{id}
func (h *Handler) GetUserHandler(w http.ResponseWriter, r *http.Request) {
	ctx, cancel := context.WithTimeout(r.Context(), DefaultTimeout)
	defer cancel()

	// Parse ID and get user
	user, err := h.service.GetUser(ctx, 1)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(user)
}

// Generic function
func Filter[T any](slice []T, predicate func(T) bool) []T {
	result := make([]T, 0, len(slice))
	for _, item := range slice {
		if predicate(item) {
			result = append(result, item)
		}
	}
	return result
}

// Goroutine example
func worker(id int, jobs <-chan int, results chan<- int) {
	for job := range jobs {
		logger.Printf("Worker %d processing job %d", id, job)
		time.Sleep(time.Second)
		results <- job * 2
	}
}

// Main function
func main() {
	fmt.Printf("CoMPhy Gruvbox Theme Demo - Go\n")
	fmt.Printf("API Version: %s\n", APIVersion)

	// Create user
	user := &User{
		ID:        1,
		Username:  "alice",
		Email:     "alice@example.com",
		Active:    true,
		CreatedAt: time.Now(),
	}

	if err := user.Validate(); err != nil {
		logger.Fatalf("Validation failed: %v", err)
	}

	fmt.Printf("User: %+v\n", user)
}
