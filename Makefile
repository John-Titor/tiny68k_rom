# Build MJSROM for Tiny68k

TOOL_PREFIX		 = /Volumes/CTNG/dst/bin/m68k-unknown-elf-
CC			 = $(TOOL_PREFIX)cc
OBJCOPY			 = $(TOOL_PREFIX)objcopy
LINKER_SCRIPT		 = tiny68k.ld
PRODUCT			 = rom
BINARY			 = $(PRODUCT).bin
ELF			 = $(PRODUCT).elf

OPTS			 = -mcpu=68000 \
			   -ffreestanding \
			   -nostdinc \
			   -nostdlib \
			   -ffunction-sections \
			   -fdata-sections \
			   -Wl,-gc-sections \
			   -Wl,-Map=elf.map

SRCS			:= $(wildcard *.c) $(wildcard *.S)
HDRS			:= $(wildcard *.h)

$(BINARY): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(ELF): $(SRCS) $(HDRS) $(LINKER_SCRIPT) $(MAKEFILE_LIST)
	$(CC) $(OPTS) -T $(LINKER_SCRIPT) -o $@ $(SRCS)

clean:
	rm -f $(BINARY) $(ELF) elf.map