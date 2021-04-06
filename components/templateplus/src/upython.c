#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "include/upython.h"

TaskHandle_t upython_entry(void) {
	return micropython_task(UPY_RUNNING_CORE);
}
