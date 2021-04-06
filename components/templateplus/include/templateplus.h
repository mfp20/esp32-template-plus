#ifndef _TEMPLATEPLUS_H_
#define _TEMPLATEPLUS_H_

#include <string.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"

#include "esp_system.h"
#include "esp_event.h"
#include "esp_event_loop.h"
#include "esp_wifi.h"

//#include "ota_server.h"

typedef void (*f_ptr_t)(void);

esp_err_t event_handler(void *, system_event_t *);

// WIFI
#if CONFIG_WIFI_ENABLE
#define WIFI_SSID CONFIG_WIFI_SSID
#define WIFI_PASSWORD CONFIG_WIFI_PASSWORD
#else
#define WIFI_SSID ""
#define WIFI_PASSWORD ""
#endif

static const int WIFI_CONNECTED_BIT = BIT0;
static EventGroupHandle_t wifi_event_group;
void wInit(void);

// TASKS
extern TaskHandle_t otaserver_entry(void);
extern TaskHandle_t arduino_entry(f_ptr_t);
extern TaskHandle_t upython_entry(void);

//
void initTemplateplus(f_ptr_t);

#endif /* _TEMPLATEPLUS_H_ */
