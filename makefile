CC = gcc
CSTD = c90

SRC_DIR = src
INC_DIR = include
OBJ_DIR = .o

CFLAGS = -Wall -Wextra -Werror -Wpedantic -I$(INC_DIR) -std=$(CSTD) -Wshadow -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wcast-qual -Wswitch-default -Wswitch-enum -Wunreachable-code -Wfloat-equal -Wconversion -Wdouble-promotion -Wmissing-prototypes -Wundef -Wunused-macros -Wwrite-strings

TARGET = program

ifeq ($(DEBUG), 1)
	CFLAGS += -g -O0
else
	CFLAGS += -O2
endif

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

all: $(OBJ_DIR) $(TARGET)

debug:
	$(MAKE) all DEBUG=1

release:
	$(MAKE) all DEBUG=0

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(TARGET): $(OBJ_FILES)
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_FILES) $(TARGET)
