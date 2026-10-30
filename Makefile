CC       := gcc
CPPFLAGS :=
LDFLAGS  := 
LDLIBS   := -lX11 -lxkbfile

PREFIX   ?= /usr/local
BINDIR   ?= $(PREFIX)/bin
PROFILE  ?= Release

TARGET   := getxkblayout

SRC_DIR  := src
BUILD_DIR:= build/$(PROFILE)

# ─── PROFILE CONFIGURATION ──────────────────────────────────────────
# Dynamically adjusts C flags based on the chosen profile
ifeq ($(PROFILE),Debug)
    CFLAGS := -O0 -g3 -DDEBUG -Wall -Wextra -std=c11
else
    CFLAGS := -O3 -Wall -Wextra -DNDEBUG -std=c11
endif
# ────────────────────────────────────────────────────────────────────

SRCS     := $(wildcard $(SRC_DIR)/*.c)
OBJS     := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

.PHONY: all clean install uninstall

all: $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf build/

install: all
	install -d $(DESTDIR)$(BINDIR)
	install -m 0755 $(BUILD_DIR)/$(TARGET) $(DESTDIR)$(BINDIR)/

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(TARGET)
