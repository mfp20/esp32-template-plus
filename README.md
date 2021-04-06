# ESP32 Template Plus #

**Currently it's just a STUB: it builds the default image with all the libs from the components folder (micropython included, see tools/micropython/ports/esp32/build/libapp.a after 'make install') but doesn't run any task yet.**

This repository contains an **esp-idf template on steroids**: in a few minutes you can have a fully functional build to flash your ESP32 with, and to jumpstart your own project.
I made it to test my tiny [M5Stack](http://www.m5stack.com/) and it works good for me. I hope you enjoy it too.

The idea is to use the Pro Core for hw management using the wide range of C-like Arduino libs (tft, audio, buttons, sensors, ota ...) and leave the App Core for uPython black magic.

But:
- the buildchain is just a very flexible barebone that can be confugured at wish.
- more and more uPython libs and c-wrappers are available every day.
- it is possible to pin any thread to any core.

In other words: defaults for M5Stack (C tasks for hw management, micropython for processing) but it is pretty easy for you to customize at wish. Memory (and battery consumption, where applicable) is the only real limit, on boards without psRAM.

## Table of Contents ##
* 1. [Features & Status](#fands)
  * 1.1. [Current terminal session](#terminal)
  * 1.2. [Features](#features)
  * 1.3. [Hardware](#hw)
* 2. [Documentation](#docs)
  * 2.1. [Install](#install)
  * 2.2. [Customize](#custom)
  * 2.3. [External resources](#res)
* 3. [TODOs](#todo)

<a name="fands"/>

## 1. Features & Status ##

The current code is a rewriting of my [old esp-template-plus](https://github.com/mfp20/esp32-template-plus-OLD) (ie: rebased on top of [esp-idf-template](https://github.com/espressif/esp-idf-template) instead of [MicroPython for ESP32 with psRAM support](https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo)), in order to make **explicit and trackable** all the changes from Espressif/Micropython/Etc repos to the actual esp-template-plus project.

Initially I reworked/cleaned [Loboris' Micropython awesome project](https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo) that lead the way for Micropython on ESP32, but then I discovered that his repo had no history back to the original projects, and its design is pretty convoluted. 
Moreover Loboris looks particularly focused on the Microphyton port, finalizing that codebase for one task only (Micropython), making the whole project unsuitable for generic templating. So, after spending a couple of days fiddling with his messy stuff, I gave up and started from the scratch, importing his component.mk files and his existing component patches.

The result is a codebase 99% trackable to the single original project's repos, and an overall clean project codebase (ex: no extra scripts to manage the project: everything is a 'make' command). Simply future proof.

This means that you don't depend on me (or Loboris) to update single components or whatever else; we are just packagers saving you a few weeks of work to understand the internals.

<a name="terminal"/>

### 1.1. Current terminal session ###

```
NO TERMINAL YET
```

<a name="features"/>

### 1.2. Features ###

The following are features tables (with current status) to help you understand what the deal is:

### 1.2.1. General ###
| Staus | Feature   | Description |
|:---:|:-------------:|:-------|
| Done | Eclipse | **Eclipse project files included**. To import the project into Eclipse go to File->Import->General->Existing Projects into Workspace, then select *esp32-template-plus* directory and click on Finish button. Finally Rebuild Index. |
| Linux Only | Install | Includes **makefile for dependencies install**. |
| WiP | CPU | Both **unicore** and **dualcore**. User can choose the core to run each task. |
| WiP | Flash | Defaults to **QIO, 80Mhz** flash memory access mode. |
| WiP | C | Includes the latest **Arduino's ESP32 libraries**. |
| WiP | C | Includes the latest **MicroPython** build from [main MicroPython repository](https://github.com/micropython/micropython). |
| WiP | OTA | **OTA push&pull** supported, various partitions layouts. |

#### 1.2.2. Components ####
| Staus | Feature   | Description |
|:---:|:-------------:|:-------|
| Done | **zlib** | A Massively Spiffy Yet Delicately Unobtrusive **Compression Library** (Also Free, Not to Mention Unencumbered by Patents). |
| Done | **libSSH2** | Library implementing the SSH2 protocol. |
| Done | **cURL** | Library for transferring data with **URLs**. |
| Done | **OTA-Server** | ESP-IDF component to add OTA push capability. |
| Done | **espMQTT** | an ISO standard publish-subscribe-based **messaging protocol**. |
| WiP | **librWiFi** | Library to **monitor and send raw 802.11 packets**. |
| WiP | **socat** | Multipurpose relay. |
| WiP | **TemplatePlus** | A **display menu and system utilities**. |

#### 1.2.3. uPython libs ####
| Staus | Feature   | Description |
|:---:|:-------------:|:-------|

<a name="hw"/>

### 1.3. Hardware ###

Several modules & development boards ship with psRAM, some examples:

* [**M5Stack**](http://www.m5stack.com) _Development Kit_ [version with psRAM](https://www.aliexpress.com/store/product/M5Stack-NEWEST-4M-PSRAM-ESP32-Development-Board-with-MPU9250-9DOF-Sensor-Color-LCD-for-Arduino-uPython/3226069_32847906756.html?spm=2114.12010608.0.0.1ba0ee41gOPji)
* **TTGO T8 V1.1** _board_, available at [eBay](https://www.ebay.com/itm/TTGO-T8-V1-1-ESP32-4MB-PSRAM-TF-CARD-3D-ANTENNA-WiFi-bluetooth/152891206854?hash=item239906acc6:g:7QkAAOSwMfhadD85)
* **ESP-WROVER-KIT** _boards_ from Espressif, available from [ElectroDragon](http://www.electrodragon.com/product/esp32-wrover-kit/), [AnalogLamb](https://www.analoglamb.com/product/esp-wrover-kit-esp32-wrover-module/), ...
* **WiPy 3.0** _board_ from [Pycom](https://pycom.io/product/wipy-3/).
* **TTGO TAudio** _board_ ([eBay](https://www.ebay.com/itm/TTGO-TAudio-V1-0-ESP32-WROVER-SD-Card-Slot-Bluetooth-WI-FI-Module-MPU9250/152835010520?hash=item2395ad2fd8:g:Jt8AAOSwR2RaOdEp))
* **Lolin32 Pro** _board_ from [Wemos](https://wiki.wemos.cc/products:lolin32:lolin32_pro) - **`no longer available`** ([Schematic](https://wiki.wemos.cc/_media/products:lolin32:sch_lolin32_pro_v1.0.0.pdf)).
* **ESP-WROVER** _module_ from Espressif, available from [ElectroDragon](http://www.electrodragon.com/product/esp32-wrover-v4-module-based-esp32/) and many other vendors.
* **ALB32-WROVER** _module_ (4 MB SPIRAM & 4/8/16 MB Flash) from [AnalogLamb](https://www.analoglamb.com/product/alb32-wrover-esp32-module-with-64mb-flash-and-32mb-psram/).
* **S01**, **L01** and **G01** _OEM modules_ from [Pycom](https://pycom.io/webshop#oem-products).

Espressif maintains [a more detailed list of ESP32 boards on the market](http://esp32.net/#Hardware). Following the boards I'm aware of working with this code:

| Board             | uPython   | Arduino | Others |
| ----------------- |:-------------:| -------:| ------:|
| M5Stack           | [works](https://github.com/mfp20)     | WiP     | WiP    |
| ESP-WROVER-KIT v3 | [works](https://github.com/loboris)     | unknown | unknown|

In any case is always possible to solder psRAM and/or extra flash yourself. Those ICs are pretty cheap and there are various different ways to solder SMD chips without the proper tools. I placed a 16MB flash on mine with aluminium foil and kapton tape to protect the board from the air gun shooting on the chip to be replaced: easypeasylemonsqueeze. Just be patient and work slow.

<a name="docs"/>

## 2. Documentation ##

<a name="install"/>

### 2.1. Install ###

1. Clone:

`git clone https://github.com/mfp20/esp-idf-template-plus.git`

2. Install:

`make install`

(remember to issue the following command in every console you need to configure/build)

`source tools/paths`

3. Then it's the same of ESP-IDF default template. Configure:

`make menuconfig`

4. Build:

`make all`

5. Flash:

`make flash`

6. Log in:

`make monitor`

7. Have fun!

<a name="custom"/>

### 2.2. Customize ###

The directory structure is the same of the original esp-idf-template with some additions:
- esp32-template-plus/firmwares: prebuilt firmware images and their configuration files (sdkconfig and partitions.csv).
- esp32-template-plus/internalfs: extra files included in the flash as internal filesystem.
- esp32-template-plus/main: contains the main.c file with the app_main() function that it is run at boot. It initializes hw and tasks. The default arduino task in turn sets the menu on display where to choose (using the hw buttons) one of the apps.c app to run on display. As well as uPython runs the default upy app. In order to drop in a custom arduino app to replace the default one, just edit the two setup/loop functions in main.c.
- esp32-template-plus/tools: contains the xtensa buildchain for Linux, esp-idf sdk, the Micropython repo, and more. There are 2 esp-idf sdks: one for micropython and one for everything else. Because Micropython currently requires an older version of the SDK.

The project is 99% open source and mostly MIT/Apache/GPL licenses. The only binary blobs are the infamous radio craps: wifi, BT, GSM, ... as usual. It means two things:
- you can customize (almost) anything at wish.
- someone else can tap in your communications, as well as steal your identity and talk/buy/whatever using your name (ie: if cops/gangsters come to get you, and you don't know why... you actually know why: "thou shall repent!!!"). It is also possible to identify you using watermarking/fingerprinting of your radios (ie: make the radio produce a unique RF micro-pattern to identify it without MAC address, IP or [other old fashioned entities](https://en.wikipedia.org/wiki/Printer_steganography)). I wonder how normal people can think to run/vote for elections, or just send each other [dick-pics](https://www.youtube.com/watch?v=XEVlyP4_11M), or whatever else... anyway... the monkeys like, the monkeys do.

<a name="res"/>

### 2.3. External resources ###

In order to merge future revisions, I mantain some bridge repos on my account. Source repos:
- https://github.com/espressif/arduino-esp32
- https://github.com/m5stack/M5Stack
- https://github.com/tomsuch/M5StackSAM
- https://github.com/yanbe/esp32-ota-server
- ... (browse my repos, I cloned all the repos I needed)
- plus other additions I cherry picked up and there.

There are thousands of links to help you with ESP32. Just to name a few:
- Espressif's [esp-idf](https://github.com/espressif/esp-idf) sdk; and it's [manual](https://esp-idf.readthedocs.io/en/latest/). 
- Loboris' [wiki](https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo/wiki), mostly focused on the uPython part; [examples](https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo/tree/master/MicroPython_BUILD/components/micropython/esp32/modules_examples) included.
- M5Stack's [website](http://www.m5stack.com/).
- Yanbe's [ota server](https://github.com/yanbe/esp32-ota-server)
- Jeija's [802.11 raw packets sending/monitoring](https://github.com/Jeija/esp32-80211-tx)
- ...

<a name="todo"/>

## 3. TODOs ##

| Staus | Feature   | Description |
|:---:|:-------------:|:-------|
| WiP | Mail | **Quickmail** adapted by Loboris to be an esp-idf component. |
| WiP | SDMMC | Supports **SD card**; it uses esp-idf's SDMMC driver and it can work in **SD mode** (*1-bit* and *4-bit*) and **SPI mode** (sd card can be connected to any pins). |
| WiP | VFS | **Native ESP32 VFS** support for spi Flash & sdcard filesystems. |
| WiP | SPIFFS | Supports a patched **SPIFFS filesystem** and it can be used instead of FatFS in SPI Flash.
| WiP | FatFS | Supports **Fat filesystem with esp-idf wear leveling driver**, so there is less danger of damaging the flash with frequent writes. |
| WiP | Flash | Proper files **timestamp** management both on internal fat filesysten and on sdcard |
| WiP | Time | **RTC Class** is added to machine module, including methods for synchronization of system time to **ntp** server, **deepsleep**, **wakeup** from deepsleep **on external pin** level, ... |
| WiP | Time | **Time zone** can be configured via **menuconfig** and is used when syncronizing time from NTP server. |
| WiP | Memory | Supports ESP32 boards **with and without psRAM**. |
| WiP | uPython | **Ymodem** module for fast transfer of text/binary files to/from host. |
| WiP | uPython | **Btree** module included, can be Enabled/Disabled via **menuconfig** . |
| WiP | uPython | **_threads** module greatly improved, inter-thread **notifications** and **messaging** included |
| WiP | uPython | **Neopixel** module using ESP32 **RMT** peripheral with many new features. |
| WiP | uPython | **DHT** module implemented using ESP32 RMT peripheral. |
| WiP | uPython | **1-wire** module implemented using ESP32 RMT peripheral. |
| WiP | uPython | **i2c** module uses ESP32 hardware i2c driver. |
| WiP | uPython | **spi** module uses ESP32 hardware spi driver. |
| WiP | uPython | **adc** module improved, new functions added. |
| WiP | uPython | **pwm** module, ESP32 hardware based. |
| WiP | uPython | **timer** module improved, new timer types and features. |
| WiP | uPython | **curl** module added, many client protocols including FTP and eMAIL. |
| WiP | uPython | **ssh** module added with sftp/scp support and _exec_ function to execute program on server. |
| WiP | uPython | **display** module added with full support for spi TFT displays. |
| WiP | uPython | **mDNS** module added, implemented in C, runs in separate task. |
| WiP | uPython | **telnet** module added, connect to **REPL via WiFi** using telnet protocol. |
| WiP | uPython | **ftp** server module added, runs as separate ESP32 task. |
| WiP | uPython | **GSM/PPPoS** support, connect to the Internet via GSM module. |
| WiP | uPython | Includes some additional frozen modules: **pye** editor, **urequests**, **functools**, **logging**, ... |

