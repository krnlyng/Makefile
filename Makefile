OUT     := prog
SRC		:= main.c
OBJ     := $(SRC:.c=.o)

CFLAGS  := -Wall -Werror -std=c99
LDFLAGS :=
LDLIBS  :=

ifeq ($(DEBUG),1)
	CFLAGS += -O0 -g3 -ggdb -pg
endif

SILENTMSG := @echo
SILENTCMD := @

.PHONY: release clean

release: CFLAGS := $(CFLAGS) -O2
release: $(OUT)

clean:
	$(SILENTMSG) -e "\tCLEAN\t"
	$(SILENTCMD)$(RM) $(OBJ) $(OBJ:.o=.d) $(OUT)

$(OUT): $(OBJ)
	$(SILENTMSG) -e "\tLINK\t$@"
	$(SILENTCMD)$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o: %.c %.d
	$(SILENTMSG) -e "\tCC\t$@"
	$(SILENTCMD)$(CC) $(CFLAGS) -c $< -o $@

%.d: %.c
	$(SILENTMSG) -e "\tDEP\t$@"
	$(SILENTCMD)$(CC) $(CFLAGS) -MF $@ -MM $<

-include $(OBJ:.o=.d)
