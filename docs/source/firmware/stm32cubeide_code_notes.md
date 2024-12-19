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

---

### UCPD

**UCPD** stands for **USB Type-C / USB Power Delivery**. It is a peripheral available in certain STM32 microcontrollers, such as the **STM32G4** series, to support USB Type-C connectivity and USB Power Delivery (USB-PD) communication.

### Features of UCPD:
1. **USB Power Delivery Communication**:  
   - Handles communication of USB PD protocol messages using **BMC (Biphase Mark Coding)** over the **CC (Configuration Channel)** pins of the Type-C connector.
   - Supports communication between a Source (power provider) and Sink (power consumer).

2. **Power Negotiation**:  
   - Allows devices to negotiate voltages (e.g., 5V, 9V, 12V, 20V) and power levels.

3. **Role Management**:  
   - Supports **Dual Role Power (DRP)**: A device can act as both power source and sink.
   - Supports **Try.SNK** and **Try.SRC** roles for negotiation priorities.

4. **USB Type-C State Management**:  
   - Detects cable attachment, orientation, and connection state using the **CC lines**.

5. **Low-Power Operation**:  
   - The UCPD peripheral is optimized for low-power communication during USB Power Delivery.

---

## Interrupt Service Routines: Core/Src/stm32g4xx_it.c

```diff
+ /**
+   * @brief This function handles EXTI line[15:10] interrupts.
+   */
+ void EXTI15_10_IRQHandler(void)
+ {
+   /* USER CODE BEGIN EXTI15_10_IRQn 0 */
+ 
+   /* USER CODE END EXTI15_10_IRQn 0 */
+   HAL_GPIO_EXTI_IRQHandler(B1_Pin);
+   /* USER CODE BEGIN EXTI15_10_IRQn 1 */
+ 
+   /* USER CODE END EXTI15_10_IRQn 1 */
+ }
```