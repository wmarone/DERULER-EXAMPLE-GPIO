.DEFAULT=all

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
ELF = flash.elf
BIN = flash.bin

SRCS =
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_exti.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc_ex.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_dma.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c_ex.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_gpio.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash_ramfunc.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_cortex.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr_ex.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash_ex.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_tim_ex.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_tim.c
SRCS += ./Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c.c
SRCS += ./Core/Src/stm32l0xx_hal_msp.c
SRCS += ./Core/Src/stm32l0xx_it.c
SRCS += ./Core/Src/system_stm32l0xx.c
SRCS += ./Core/Src/main.c
SRCS += ./Core/Src/syscalls.c
SRCS += ./Core/Src/sysmem.c

ASM = ./Core/Startup/startup_stm32l051k6tx.s

COBJS = $(SRCS:.c=.o)

AOBJS = $(ASM:.s=.o)

INCLUDE =
INCLUDE += -I /usr/lib/gcc/arm-none-eabi/7.3.1/include
INCLUDE += -I ./Drivers/CMSIS/Device/ST/STM32L0xx/Include/
INCLUDE += -I ./Drivers/CMSIS/Include/
INCLUDE += -I ./Drivers/STM32L0xx_HAL_Driver/Inc/
INCLUDE += -I ./Core/Inc/

CFLAGS = -Os -mcpu=cortex-m0 -DSTM32L051xx

all: $(BIN)

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

$(ELF): $(COBJS) $(AOBJS)
	$(CC) $(CFLAGS) $(INCLUDE) $(AOBJS) $(COBJS) -T STM32L051K6TX_FLASH.ld -o $(ELF)

$(AOBJS): $(ASM)
	$(CC) -c $(CFLAGS) $(INCLUDE) $(@:.o=.s) -o $@

$(COBJS): $(SRCS)
	$(CC) -c $(CFLAGS) $(INCLUDE) $(@:.o=.c) -o $@

clean:
	rm -rf $(COBJS) $(AOBJS) $(ELF) $(BIN)
