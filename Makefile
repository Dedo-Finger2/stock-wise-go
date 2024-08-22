run-dev:
	go run ./...

test-all:
	go test -v ./...

test-config:
	go test -v ./internal/config/

test-unit:
	go test -v ./internal/**/**/*_unit_test.go

test-e2e:
	go test -v ./internal/**/**/*_e2e_test.go

test-integration:
	go test -v ./internal/**/**/*_integration_test.go

build:
	go build -o ./bin/stockwise ./cmd/stock-wise/main.go

build-linux:
	GOOS=linux GOARCH=amd go build -o ./bin/stockwise ./cmd/stock-wise/main.go

build-linux-64:
	GOOS=linux GOARCH=amd64 go build -o ./bin/stockwise ./cmd/stock-wise/main.go

build-windows:
	GOOS=windows GOARCH=amd go build -o ./bin/stockwise.exe ./cmd/stock-wise/main.go

build-windows-64:
	GOOS=windows GOARCH=amd64 go build -o ./bin/stockwise.exe ./cmd/stock-wise/main.go