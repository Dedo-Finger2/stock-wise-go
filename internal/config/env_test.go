package config_test

import (
	"testing"

	"github.com/Dedo-Finger2/stock-wise-go/internal/config"
)

func Test_EnvVariables(t *testing.T) {
	env := config.GetEnvVariables()

	t.Run("SERVER_PORT is not empty", func(t *testing.T) {
		isServerPortValid := env.SERVER_PORT != ""
		if !isServerPortValid {
			t.Error("expected SERVER_PORT to be valid, but got empty string instead.")
		}
	})

	t.Run("SERVER_PORT starts with ':'", func(t *testing.T) {
		isServerPortFormatted := env.SERVER_PORT[0] == ':'
		if !isServerPortFormatted {
			t.Error("expected SERVER_PORT to start with a ':' but it was not found in the string returned.")
		}
	})

}
