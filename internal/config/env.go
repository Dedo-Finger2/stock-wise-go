package config

import (
	"os"

	"github.com/joho/godotenv"
)

type env struct {
	SERVER_PORT string
}

func GetEnvVariables() env {
	godotenv.Load()

	envVariables := env{
		SERVER_PORT: ":" + os.Getenv("SERVER_PORT"),
	}

	return envVariables
}
