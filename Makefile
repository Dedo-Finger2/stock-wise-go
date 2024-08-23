run-dev:
	go run ./...

test-all:
	go test -v ./...

test-config:
	go test -v ./internal/config/

test-unit:
	for file in $(shell find ./internal -name '*_unit_test.go'); do \
		go test -v $$file || exit 1; \
	done

test-e2e:
	for file in $(shell find ./internal -name '*_e2e_test.go'); do \
		go test -v $$file || exit 1; \
	done

test-integration:
	for file in $(shell find ./internal -name '*_integration_test.go'); do \
		go test -v $$file || exit 1; \
	done

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