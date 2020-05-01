###############################################################################
#
# Makefile
#
# Inspiration: https://ipfs-sec.stackexchange.cloudflare-ipfs.com/tex/A/question/122241.html
#
# Usage: run `make all` from root directory of project
#
###############################################################################

DEBUG="true"
ROOT_DIR=$(shell pwd)
BUILD_DIR=$(ROOT_DIR)/.build
OUTPUT_DIR=$(ROOT_DIR)/output
.PHONY: clean clearscreen

XELATEX_OPTS=-output-directory=$(BUILD_DIR)
BIBER_OPTS=-output-directory=$(BUILD_DIR)

all: copy_sources doc copy_output

clean:
	@echo "Cleaning out the build and output directories..."
	@cd $(BUILD_DIR); rm -rf *
	@cd $(OUTPUT_DIR); rm -rf *

copy_sources:
	@echo "Copying sources to build directory: $(BUILD_DIR)"
	@rsync --verbose --checksum --recursive --human-readable --progress --exclude=.build --exclude=.build_scripts --exclude=output --exclude=.git --exclude=.gitignore $(ROOT_DIR)/ $(BUILD_DIR)

copy_output:
	@echo "Copying generated PDFs to output folder: $(OUTPUT_DIR)"
	@cp -f $(BUILD_DIR)/*.pdf $(OUTPUT_DIR)

doc:
	@echo "Building screen version ..."
ifeq ($(DEBUG) , 'true')
	.build_scripts/screen.sh $(BUILD_DIR) $(DEBUG) 
else
	.build_scripts/screen.sh $(BUILD_DIR) $(DEBUG)
endif

clearscreen: clear
