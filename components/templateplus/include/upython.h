#ifndef UPYTHON_H
#define UPYTHON_H

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#if CONFIG_FREERTOS_UNICORE
#define UPY_RUNNING_CORE 0
#else
#define UPY_RUNNING_CORE CONFIG_ENABLE_UPY_CORE
#endif

typedef void (*f_ptr_t)(void);
extern TaskHandle_t micropython_task(int);

TaskHandle_t upython_entry(void);

#endif /* UPYTHON_H */
