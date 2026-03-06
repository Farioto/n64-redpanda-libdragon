TARGET = panda
BUILD_DIR = build
FSYSTEM_DIR = filesystem
include $(N64_INST)/include/n64.mk

# ---------------------------------------------------------
# SOURCE + ASSETS CONFIGURATION
# ---------------------------------------------------------

# Source JPG (static, in repo)
PANDA_JPG = assets/panda.jpg

# Generated PNG (goes in build/, NOT assets/)
GEN_ASSETS = $(BUILD_DIR)/assets
PANDA_PNG = $(GEN_ASSETS)/panda.png

# Output sprite
PANDA_SPRITE = $(FSYSTEM_DIR)/panda.sprite

# Objects to compile
OBJS = $(BUILD_DIR)/main.o

# The DFS needs a list of all converted assets.
# For this project, that is ONLY panda.sprite.
assets_conv = $(PANDA_SPRITE)

all: $(TARGET).z64

# ---------------------------------------------------------
# IMAGE CONVERSION
# ---------------------------------------------------------

# Convert JPG → PNG into build/assets/
$(PANDA_PNG): $(PANDA_JPG)
	@mkdir -p $(GEN_ASSETS)
	@echo "    [CONVERT] $< --> $@"
	magick "$<" "$@"

# ---------------------------------------------------------
# SPRITE GENERATION
# ---------------------------------------------------------

# Panda sprite uses RGBA16 (no tiling)
filesystem/panda.sprite: MKSPRITE_FLAGS=--format RGBA16

# Explicit chain: panda.sprite depends on panda.png in build/assets/
$(PANDA_SPRITE): $(PANDA_PNG)
	@mkdir -p $(dir $@)
	@echo "    [SPRITE] $@"
	@$(N64_MKSPRITE) $(MKSPRITE_FLAGS) -o $(FSYSTEM_DIR) "$<"

# (Generic rule kept for future sprites if you add more PNGs later)
$(FSYSTEM_DIR)/%.sprite: $(GEN_ASSETS)/%.png
	@mkdir -p $(dir $@)
	@echo "    [SPRITE] $@"
	@$(N64_MKSPRITE) $(MKSPRITE_FLAGS) -o $(FSYSTEM_DIR) "$<"

# ---------------------------------------------------------
# BUILD RULES
# ---------------------------------------------------------

# DFS must depend on the converted sprite
# Let n64.mk provide the mkdfs recipe; we only declare dependencies here.
$(BUILD_DIR)/$(TARGET).dfs: $(assets_conv)

# ELF depends on compiled objects
$(BUILD_DIR)/$(TARGET).elf: $(OBJS)

# ROM depends on ELF + DFS
$(TARGET).z64: N64_ROM_TITLE="Red Panda Boop"
$(TARGET).z64: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).dfs

clean:
	rm -rf $(BUILD_DIR) $(FSYSTEM_DIR) $(TARGET).z64 $(TARGET).pak

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
