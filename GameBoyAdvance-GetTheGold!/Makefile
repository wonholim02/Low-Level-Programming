PROGNAME = getTheGold
OFILES = gba.o font.o main.o images/startPage.o images/victory.o images/end2.o images/gold.o images/rift.o images/fox.o images/baron.o images/ani1.o images/ani2.o images/ani3.o images/ani4.o
.PHONY: all
all: CFLAGS += $(CRELEASE) -I../shared
all: LDFLAGS += $(LDRELEASE)
all: $(PROGNAME).gba
	@echo "[FINISH] Created $(PROGNAME).gba"

include /opt/cs2110-tools/GBAVariables.mak

LDFLAGS += --specs=nosys.specs

CFLAGS += -Wstrict-prototypes -Wold-style-definition -Werror=vla

.PHONY: debug
debug: CFLAGS += $(CDEBUG) -I../shared
debug: LDFLAGS += $(LDDEBUG)
debug: $(PROGNAME).gba
	@echo "[FINISH] Created $(PROGNAME).gba"

$(PROGNAME).gba: $(PROGNAME).elf
	@echo "[LINK] Linking objects together to create $(PROGNAME).gba"
	@$(OBJCOPY) -O binary $(PROGNAME).elf $(PROGNAME).gba

$(PROGNAME).elf: crt0.o $(GCCLIB)/crtbegin.o $(GCCLIB)/crtend.o $(GCCLIB)/crti.o $(GCCLIB)/crtn.o $(OFILES) libc_sbrk.o
	$(CC) -o $(PROGNAME).elf $^ $(LDFLAGS)

.PHONY: release
release: CFLAGS += $(CRELEASE) -I../shared
release: LDFLAGS += $(LDRELEASE)
release: $(PROGNAME).gba
	@echo "Built $(PROGNAME).gba with release flags"

.PHONY: mgba
mgba: debug
	@echo "[EXECUTE] Running emulator mGBA"
	@echo "          Please see emulator.log if this fails"
	@mgba-qt $(PROGNAME).gba

.PHONY: gdb
gdb: debug
	@echo "[EXECUTE] Running Emulator MGBA with GDB"
	@echo "          Please see emulator.log if this fails"
	@mgba-qt $(PROGNAME).gba --gdb &
	# To give mgba some time to initialize and start up the GDB server.
	@sleep 0.5
	@gdb-multiarch -ex 'file $(PROGNAME).elf' -ex 'target remote 127.0.0.1:2345'

.PHONY: submit
submit: clean
	@rm -f submission.tar.gz
	@tar --exclude="examples" -czvf submission.tar.gz *

.PHONY: maze
maze: 
	@echo "[EXECUTE] Running emulator mGBA"
	@echo "          Please see emulator.log if this fails"
	@mgba-qt examples/maze/Maze.gba

.PHONY: mario
mario: 
	@echo "[EXECUTE] Running emulator mGBA"
	@echo "          Please see emulator.log if this fails"
	@mgba-qt examples/mario/Mario.gba

.PHONY: clean
clean:
	@echo "[CLEAN] Removing all compiled files"
	rm -f *.o *.elf *.gba *.log */*.o *.sav */*/*.sav