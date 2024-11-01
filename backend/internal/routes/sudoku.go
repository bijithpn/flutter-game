package routes

import (
	"github.com/cheatsnake/shadify/internal/handlers"
	"github.com/gofiber/fiber/v2"
)

func SudokuRouter(app fiber.Router) {
	prefix := "/api/sudoku"

	app.Get(prefix+"/generator", handlers.SudokuGenerator)
	app.Get(prefix+"/verifier", handlers.SudokuVerificationGet)
	app.Post(prefix+"/verifier", handlers.SudokuVerificationPost)
}
