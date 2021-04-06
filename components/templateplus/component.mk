MKDEBUG := 1

ARDUINO_DEPS := arduino-esp32/cores/esp32/libb64
ARDUINO_CORE := $(patsubst $(COMPONENT_PATH)/%,%,$(sort $(dir $(wildcard $(COMPONENT_PATH)/arduino-esp32/cores/esp32/))))
ifeq ($(CONFIG_M5STACK),1)
	ARDUINO_CORE += arduino-esp32/variants/m5stack-core-esp32
else
	ARDUINO_CORE += arduino-esp32/variants/esp32
endif
ARDUINO_CORE_SRCS := $(filter-out arduino-esp32/cores/esp32/main.c, $(sort $(patsubst $(COMPONENT_PATH)/%,%,$(shell find $(COMPONENT_PATH)/arduino-esp32/cores/esp32/ -name '*.c' -o -name '*.cpp'))))
ARDUINO_CORE_OBJS := $(ARDUINO_CORE_SRCS:%.cpp=%.o)
ARDUINO_CORE_LIBS := $(patsubst $(COMPONENT_PATH)/%,%,$(sort $(dir $(wildcard $(COMPONENT_PATH)/arduino-esp32/libraries/*/*/))))
ARDUINO_CORE_LIBS_SRCS := $(patsubst $(COMPONENT_PATH)/%,%,$(shell find $(COMPONENT_PATH)/arduino-esp32/libraries/*/*/ -name '*.c' -o -name '*.cpp'))
ARDUINO_CORE_LIBS_OBJS := $(ARDUINO_CORE_LIBS_SRCS:%.cpp=%.o)

UPYTHON_DEPS := 
UPYTHON := 
UPYTHON_CORE_SRCS := 
UPYTHON_CORE_OBJS := 
UPYTHON_LIBS := 
UPYTHON_LIBS_SRCS := 
UPYTHON_LIBS_OBJS := 

COMPONENT_PRIV_INCLUDEDIRS := $(ARDUINO_DEPS)

COMPONENT_ADD_INCLUDEDIRS := include $(ARDUINO_CORE) $(ARDUINO_CORE_LIBS) 

#COMPONENT_ADD_INCLUDEDIRS := .  genhdr py esp32 lib lib/utils lib/mp-readline extmod extmod/crypto-algorithms lib/netutils drivers/dht \
#							 lib/timeutils  lib/berkeley-db-1.xx/include lib/berkeley-db-1.xx/btree \
#							 lib/berkeley-db-1.xx/db lib/berkeley-db-1.xx/hash lib/berkeley-db-1.xx/man lib/berkeley-db-1.xx/mpool lib/berkeley-db-1.xx/recno \
#							 ../curl/include ../curl/lib ../zlib ../libssh2/include ../espmqtt/include
#

#COMPONENT_SRCDIRS := src $(ARDUINO_DEPS) $(ARDUINO_CORE) $(ARDUINO_CORE_LIBS)

#COMPONENT_OBJS := $(ARDUINO_CORE_OBJS)

CXXFLAGS += -fno-rtti

#COMPONENT_ADD_LDFLAGS := -L $(COMPONENT_PATH) -lapp

ifeq ($(MKDEBUG),1)
$(info ***************)
$(info *** ARDUINO ***)
$(info *** ARDUINO_DEPS: $(ARDUINO_DEPS))
$(info *** ARDUINO_CORE: $(ARDUINO_CORE))
$(info *** ARDUINO_CORE_SRCS: $(ARDUINO_CORE_SRCS))
$(info *** ARDUINO_CORE_OBJS: $(ARDUINO_CORE_OBJS))
$(info *** ARDUINO_CORE_LIBS: $(ARDUINO_CORE_LIBS))
$(info *** ARDUINO_CORE_LIBS_SRCS: $(ARDUINO_CORE_LIBS_SRCS))
$(info *** ARDUINO_CORE_LIBS_OBJS: $(ARDUINO_CORE_LIBS_OBJS))
$(info ***************)
$(info *** UPYTHON ***)
$(info *** UPYTHON_DEPS: $(UPYTHON_DEPS))
$(info *** UPYTHON: $(UPYTHON))
$(info *** UPYTHON_CORE_SRCS: $(UPYTHON_CORE_SRCS))
$(info *** UPYTHON_CORE_OBJS: $(UPYTHON_CORE_OBJS))
$(info *** UPYTHON_LIBS: $(UPYTHON_LIBS))
$(info *** UPYTHON_LIBS_SRCS: $(UPYTHON_LIBS_SRCS))
$(info *** UPYTHON_LIBS_OBJS: $(UPYTHON_LIBS_OBJS))
$(info ***************)
$(info *** COMPONENT_OBJS: $(COMPONENT_OBJS))
endif


build:
	echo "****************** BUILD EXTRAS ***********************"
	
clean:
	