#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "Arduino.h"
#include "include/ardulibs.h"

void arl_task(f_ptr_t *pvParameters)
{
#if	CONFIG_COMPONENT_ARDUINO_AUTOSTART
#else
	vTaskSuspend( NULL );
#endif

	f_ptr_t *setup = &pvParameters[0];
	f_ptr_t *loop = &pvParameters[1];

	setup();
    for(;;) {
        micros(); //update overflow
        loop();
    }
}

TaskHandle_t arduino_entry(f_ptr_t arl)
{
    initArduino();
    return xTaskCreateStaticPinnedToCore(&arl_task, "arl_task", ARL_TASK_STACK_LEN, &arl, ARL_TASK_PRIORITY, &arl_task_stack[0], &arl_task_tcb, ARL_RUNNING_CORE);
}
