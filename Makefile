BUILD_DIR := build
GENERATOR := Ninja

.PHONY: all configure build run test clean rebuild

all: build

configure:
	cmake -S . -B $(BUILD_DIR) -G $(GENERATOR)

build: configure
	cmake --build $(BUILD_DIR)

run: build
	cmake --build $(BUILD_DIR) --target my_app
	"$(BUILD_DIR)\bin\my_app.exe"

test: build
	ctest --test-dir $(BUILD_DIR) --output-on-failure

rebuild: clean build

# --------- Cross-platform clean ---------
ifeq ($(OS),Windows_NT)
clean:
	if exist "$(BUILD_DIR)" rmdir /s /q "$(BUILD_DIR)"
else
clean:
	rm -rf "$(BUILD_DIR)"
endif
