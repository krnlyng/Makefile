OUT     := prog
SRC		:= main.c
OBJ     := $(SRC:.c=.o)
DEP     := $(SRC:.c=.d)

CFLAGS  := -Wall -Werror -std=c99
LDFLAGS :=
LDLIBS  :=

ifeq ($(DEBUG),1)
	CFLAGS += -O0 -g3 -ggdb -pg
endif

ifeq ($(VERBOSE),1)
	SILENTMSG := @true
	SILENTCMD :=
else
	SILENTMSG := @echo
	SILENTCMD := @
endif

.PHONY: release clean

release: CFLAGS += -O2
release: $(OUT)

clean:
	$(SILENTMSG) -e "\tCLEAN\t"
	$(SILENTCMD)$(RM) $(OBJ) $(DEP) $(OUT)

$(OUT): $(OBJ)
	$(SILENTMSG) -e "\tLINK\t$@"
	$(SILENTCMD)$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o: %.c %.d
	$(SILENTMSG) -e "\tCC\t$@"
	$(SILENTCMD)$(CC) $(CFLAGS) -c $< -o $@

%.d: %.c
	$(SILENTMSG) -e "\tDEP\t$@"
	$(SILENTCMD)$(CC) $(CFLAGS) -MF $@ -MM $<

-include $(DEP)
