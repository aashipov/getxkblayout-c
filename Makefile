CC       = gcc
CFLAGS   = -O3
LDLIBS   := -lX11 -lxkbfile

PREFIX   ?= /usr/local
PROFILE  ?= Release

TARGET   := getxkblayout

SRC_DIR  := src
BUILD_DIR:= build/$(PROFILE)

SRCS     := $(wildcard $(SRC_DIR)/*.c)
OBJS     := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

.PHONY: all clean

all: clean $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BUILD_DIR)/$@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR) $(TARGET)

install:
	install -m 0755 $(BUILD_DIR)/$(TARGET) $(PREFIX)/bin/

uninstall:
	rm $(PREFIX)/bin/$(TARGET)
