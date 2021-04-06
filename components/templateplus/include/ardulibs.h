#ifndef ARDULIBS_H
#define ARDULIBS_H

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "esp_task.h"

#if CONFIG_FREERTOS_UNICORE
#define ARL_RUNNING_CORE 0
#else
#define ARL_RUNNING_CORE CONFIG_COMPONENT_ARDUINO_CORE
#endif

// Arduino runs as a task under FreeRTOS
#define ARL_TASK_PRIORITY        (ESP_TASK_PRIO_MIN + 1)
#define ARL_TASK_STACK_SIZE      (16 * 1024)
#define ARL_TASK_STACK_LEN       (ARL_TASK_STACK_SIZE / sizeof(StackType_t))
//#define ARL_TASK_HEAP_SIZE       (96 * 1024)

static StaticTask_t arl_task_tcb;
static StackType_t arl_task_stack[ARL_TASK_STACK_LEN] __attribute__((aligned (8)));
//static uint8_t arl_task_heap[ARL_TASK_HEAP_SIZE];

typedef void (*f_ptr_t)(void);

void arl_task(f_ptr_t *);
TaskHandle_t arduino_entry(f_ptr_t);

#endif /* ARDULIBS_H */
