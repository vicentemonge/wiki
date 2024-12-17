Difference between MCU vs NUCLEO
==================================

## Core/Inc/main.h

PIN - NAME ASSIGNATION

```c
#define B1_Pin GPIO_PIN_13
#define B1_GPIO_Port GPIOC
#define B1_EXTI_IRQn EXTI15_10_IRQn
#define RCC_OSC32_IN_Pin GPIO_PIN_14
#define RCC_OSC32_IN_GPIO_Port GPIOC
#define RCC_OSC32_OUT_Pin GPIO_PIN_15
#define RCC_OSC32_OUT_GPIO_Port GPIOC
#define RCC_OSC_IN_Pin GPIO_PIN_0
#define RCC_OSC_IN_GPIO_Port GPIOF
#define RCC_OSC_OUT_Pin GPIO_PIN_1
#define RCC_OSC_OUT_GPIO_Port GPIOF
#define LPUART1_TX_Pin GPIO_PIN_2
#define LPUART1_TX_GPIO_Port GPIOA
#define LPUART1_RX_Pin GPIO_PIN_3
#define LPUART1_RX_GPIO_Port GPIOA
#define LD2_Pin GPIO_PIN_5
#define LD2_GPIO_Port GPIOA
#define T_SWDIO_Pin GPIO_PIN_13
#define T_SWDIO_GPIO_Port GPIOA
#define T_SWCLK_Pin GPIO_PIN_14
#define T_SWCLK_GPIO_Port GPIOA
#define T_SWO_Pin GPIO_PIN_3
#define T_SWO_GPIO_Port GPIOB
```

## HAL configuration file: Core/Inc/stm32g4xx_hal_conf.h

External oscillator clock frequency in NUCLEO is 24Hz:

```diff
- #define HSE_VALUE    (8000000UL) /*!< Value of the External oscillator in Hz */
+ #define HSE_VALUE    (24000000UL) /*!< Value of the External oscillator in Hz */
```

HAL system configuration section. System tick priority to the highest (0), this will be a bug:

```diff
- #define  TICK_INT_PRIORITY           (15UL)    /*!< tick interrupt priority (lowest by default)  */
+ #define  TICK_INT_PRIORITY           (0UL)    /*!< tick interrupt priority (lowest by default)  */
```

## Interrupt handlers: Core/Inc/stm32g4xx_it.h

```diff
+ void EXTI15_10_IRQHandler(void);
```

## MSP (MCU Specific Package) init/deinit: Core/Src/stm32g4xx_hal_msp.c

```diff
void HAL_MspInit(void)
{
...
+  /** Disable the internal Pull-Up in Dead Battery pins of UCPD peripheral
+  */
+  HAL_PWREx_DisableUCPDDeadBattery();
...
}
```