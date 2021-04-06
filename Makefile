#
# This is a project Makefile. It is assumed the directory this Makefile resides in is a
# project subdirectory.
#

PROJECT_NAME := esp32-template-plus

SHELL := /bin/bash
CWD := $(shell pwd)
BUILDCHAIN := xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz
SDK := esp-idf
SDKUPY := $(SDK)-2c95a77

configure:

fetch:
ifeq (,$(wildcard tools/misc/$(BUILDCHAIN)))
	@wget https://dl.espressif.com/dl/$(BUILDCHAIN) -O tools/misc/$(BUILDCHAIN)
endif
ifeq (,$(wildcard tools/esp-idf))
	git submodule add -f https://github.com/mfp20/esp-idf.git tools/esp-idf
endif
ifeq (,$(wildcard tools/mkspiffs))
	git submodule add -f https://github.com/mfp20/mkspiffs.git tools/mkspiffs
endif
ifeq (,$(wildcard main/arduino-esp32))
	git submodule add -f https://github.com/mfp20/arduino-esp32.git components/arduino-esp32
endif
ifeq (,$(wildcard main/micropython))
	git submodule add -f https://github.com/mfp20/micropython.git components/micropython
endif
# libquickmail
#cd tools
#wget "https://downloads.sourceforge.net/project/libquickmail/libquickmail-0.1.25.tar.xz" -C tools/misc
# zlib
#wget "https://www.zlib.net/zlib-1.2.11.tar.gz" -C tools/misc
	@git submodule update --init --recursive
	@echo "Sources fetched."

buildchain:
ifeq (,$(wildcard tools/xtensa-esp32-elf))
	@tar -zxf tools/misc/$(BUILDCHAIN) -C tools/
endif
ifneq (,$(wildcard tools/paths))
	rm tools/paths
endif
	@echo "export PATH=$(PATH):$(CWD)/tools/xtensa-esp32-elf/bin" >> tools/paths
	@echo "--------------------------"
	@echo "Buildchain installed, please set the new PATH variable with: "
	@echo "	export PATH=$(PATH):$(CWD)/tools/xtensa-esp32-elf/bin"
	@echo "--------------------------"

sdk:
	@echo "export IDF_PATH=$(CWD)/tools/$(SDK)" >> tools/paths
	@echo "--------------------------"
	@echo "ESP-IDF sdk installed, please set the new IDF_PATH variable with: "
	@echo "	export IDF_PATH=$(CWD)/tools/esp-idf"
	@echo "--------------------------"

mkspiffs:
	@cd tools/mkspiffs; make dist BUILD_CONFIG_NAME="-esp-idf" CFLAGS="-DSPIFFS_OBJ_META_LEN=4"

upython:
ifeq (,$(wildcard tools/$(SDKUPY)))
	@git clone tools/$(SDK) tools/$(SDKUPY)
	@cd tools/$(SDKUPY);git checkout 2c95a77cf93781f296883d5dbafcdc18e4389656;git submodule update --init --recursive
endif
	@cd tools/micropython;make -C mpy-cross;cd ports/esp32;PATH=$(PATH):$(CWD)/tools/xtensa-esp32-elf/bin ESPIDF=$(CWD)/tools/$(SDKUPY) make -j8 libs
	cp $(CWD)/tools/micropython/ports/esp32/build/lib*.a $(CWD)/components/templateplus/
#	@cp $(CWD)/src/micropython/sources/ports/esp32/build/genhdr/*.h $(CWD)/components/upython/include
	@echo "--------------------------"
	@echo "uPython lib installed."
	@echo "--------------------------"

install: fetch buildchain sdk mkspiffs upython
	@echo "--------------------------"
	@echo "Be sure to set all the paths: "
	@echo "	source tools/paths"
	@echo "--------------------------"

pristine:
	make clean
	rm -Rf tools/xtensa-esp32-elf
	rm -Rf tools/esp-idf*
	rm tools/paths

-include $(IDF_PATH)/make/project.mk

