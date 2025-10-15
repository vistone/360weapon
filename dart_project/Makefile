# Makefile for Dart Project

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make install    - Install dependencies"
	@echo "  make run        - Run the main application"
	@echo "  make test       - Run all tests"
	@echo "  make coverage   - Generate test coverage report"
	@echo "  make analyze    - Run static analysis"
	@echo "  make format     - Format all Dart files"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make docs       - Generate API documentation"

.PHONY: install
install:
	dart pub get

.PHONY: run
run:
	dart run bin/main.dart

.PHONY: test
test:
	dart test

.PHONY: test-verbose
test-verbose:
	dart test --reporter expanded

.PHONY: coverage
coverage:
	dart test --coverage coverage
	dart pub global activate coverage
	dart pub global run coverage:format_coverage \
		--lcov \
		--in=coverage \
		--out=coverage/lcov.info \
		--packages=.packages \
		--report-on=lib

.PHONY: analyze
analyze:
	dart analyze

.PHONY: format
format:
	dart format .

.PHONY: format-check
format-check:
	dart format --output=none --set-exit-if-changed .

.PHONY: clean
clean:
	rm -rf .dart_tool
	rm -rf .packages
	rm -rf build
	rm -rf coverage
	rm -f pubspec.lock

.PHONY: docs
docs:
	dart doc

.PHONY: build
build:
	dart compile exe bin/main.dart -o bin/dart_project

.PHONY: watch
watch:
	@echo "Watching for changes..."
	@while true; do \
		make test; \
		inotifywait -e modify -r lib test; \
	done

.PHONY: check
check: format-check analyze test
	@echo "All checks passed!"

.PHONY: pre-commit
pre-commit: format analyze test
	@echo "Ready to commit!"