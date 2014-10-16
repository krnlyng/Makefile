OUT     := prog
SRC		:= main.c
OBJ     := $(SRC:.c=.o)

CFLAGS  := -Wall -Werror -std=c99
LDFLAGS :=
LDLIBS  :=

.PHONY: release debug clean

release: CFLAGS := $(CFLAGS) -O2
release: $(OUT)

debug:   CFLAGS := $(CFLAGS) -O0 -g3 -ggdb -pg
debug:   $(OUT)

clean:
	$(RM) $(OBJ) $(OBJ:.o=.d) $(OUT)

$(OUT): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o: %.c %.d
	$(CC) $(CFLAGS) -c $< -o $@

%.d: %.c
	$(CC) $(CFLAGS) -MF $@ -MM $<

-include $(OBJ:.o=.d)
