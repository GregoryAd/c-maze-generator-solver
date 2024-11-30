# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -pedantic -g -Iinclude
LDFLAGS =  # Add linker flags here, e.g., -lm for math library

# Project settings
TARGET = bin/maze
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC))

# Default target
all: $(BIN_DIR) $(OBJ_DIR) $(TARGET)

# Rule to create the target executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Rule to compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create the object and binary directories if they don't exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# Debugging
debug: CFLAGS += -DDEBUG
debug: clean all

# Phony targets
.PHONY: all clean debug