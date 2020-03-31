
# Fix For MACOS compability
if (APPLE)
    set(HAVE_FLAG_SEARCH_PATHS_FIRST 0)
endif()
# TODO: set as default?

# Parameters (TODO: move them somewhere else)
set(uGFX_DRIVERS ILI9341) # TODO: required?
set(uGFX_LLD_CONFIG "gdisp_lld_config.h") # TODO: required?
#set(DISCOVERY_BOARD_DISC1 TRUE) # set to enable debugging for DISC1 Boards
#SET(TOOLCHAIN_PREFIX "/usr/local") # Set depending on System (f.e. Homebrew)

PROJECT(STM32F4_UGFX)

set(CMAKE_BUILD_TYPE Debug)
set( CMAKE_EXPORT_COMPILE_COMMANDS ON )
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
ENABLE_LANGUAGE(ASM)

# Remove -rdynamic option from linking that is not supported by arm-none-eabi
# Also remove "undefined reference to `_sbrk'" error
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-specs=nano.specs -specs=nosys.specs")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

set(STM32_CHIP STM32F429ZIT)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_MODULE_PATH}/gcc_stm32.cmake)
include(${CMAKE_TOOLCHAIN_FILE})

set(CMAKE_LIBRARY_PATH ${PROJECT_SOURCE_DIR}/lib)

FIND_PACKAGE(Git REQUIRED)
set(CUBE_SOURCE "${CMAKE_LIBRARY_PATH}/STM32F4-Cube-Firmware")
if(EXISTS ${CUBE_SOURCE})
    message("Cube FW directory exists")
else()
    message("Getting Cube Firmware")
    set(GIT_REPOSITORY "https://github.com/alxhoff/STM32F4-Cube-Firmware.git")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} ${CUBE_SOURCE})
endif()

set(STM32Cube_DIR ${CUBE_SOURCE})

set(uGFX_SOURCE "${CMAKE_LIBRARY_PATH}/uGFX-Fork")
if(EXISTS ${uGFX_SOURCE})
    message("uGFX directroy exists")
else()
    message("Getting uGFX Source")
    set(GIT_REPOSITORY "https://github.com/alxhoff/uGFX-Fork.git")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} ${uGFX_SOURCE})
endif()

set(uGFX_DIR ${uGFX_SOURCE})

set(STM32_STD_SOURCE "${CMAKE_LIBRARY_PATH}/STM32F4xx-standard-peripherals-library")
if(EXISTS ${STM32_STD_SOURCE})
    message("STM32 STD directroy exists")
else()
    message("Getting STM32 STD Source")
    set(GIT_REPOSITORY "https://github.com/alxhoff/STM32F4xx-standard-peripherals-library")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} ${STM32_STD_SOURCE})
endif()

set(STM32STD_DIR ${STM32_STD_SOURCE})

set(STM32_DISC_SOURCE "${CMAKE_LIBRARY_PATH}/STM32F429I-Discovery-Firmware")
if(EXISTS ${STM32_DISC_SOURCE})
    message("STM32F429I Discovery directroy exists")
else()
    message("Getting STM32F429I Discovery Source")
    set(GIT_REPOSITORY "https://github.com/alxhoff/STM32F429I-Discovery-Firmware")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} ${STM32_DISC_SOURCE})
endif()

set(STM32Discovery_DIR ${STM32_DISC_SOURCE})

SET(FREERTOS_HEAP_IMPL 4)
SET(CMAKE_C_FLAGS "-mcpu=cortex-m4 -march=armv7e-m -mtune=cortex-m4 -mlittle-endian -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -std=c99 -Wall -Wunused-value -O3 -ffast-math -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-common --param max-inline-insns-single=1000 -DUSE_STDPERIPH_DRIVER -DGFX_USE_OS_FREERTOS=TRUE -DSTM32F429_439xx=TRUE -g3")

FIND_PACKAGE(FreeRTOS)
FIND_PACKAGE(STM32STD COMPONENTS dma dma2d fmc i2c ltdc gpio rcc spi usart adc tim exti syscfg REQUIRED)
FIND_PACKAGE(STM32Discovery COMPONENTS ioe lcd sdram REQUIRED)
FIND_PACKAGE(uGFX COMPONENTS gdisp_mcufont gdriver gdisp gos REQUIRED)

INCLUDE_DIRECTORIES(
    ${CMAKE_CURRENT_SOURCE_DIR}
    "${PROJECT_SOURCE_DIR}/inc"
    ${STM32LL_INCLUDE_DIR}
    ${STM32STD_INCLUDE_DIR}
    ${STM32Discovery_INCLUDE_DIR}
    ${FreeRTOS_INCLUDE_DIRS}
    ${uGFX_INCLUDE_DIRS}
    )

file(GLOB USER_SOURCES "src/*.c")

SET(STM32_LINKER_SCRIPT ${CMSIS_LINKER_SCRIPT})

SET(PROJECT_ELF_FILE ${CMAKE_PROJECT_NAME}.elf)
SET(PROJECT_BIN_FILE ${CMAKE_PROJECT_NAME}.bin)

SET(PROJECT_SOURCES
    ${USER_SOURCES}
    ${STM32STD_SOURCES}
    ${STM32Discovery_SOURCES}
    ${STM32LL_SOURCES}
    ${FreeRTOS_SOURCES}
    ${uGFX_SOURCES}
    gdisp_lld_ILI9341.c
    startup_stm32f429_439xx.S
    system_stm32f4xx.c
    )

ADD_EXECUTABLE(
    ${PROJECT_ELF_FILE}
    ${PROJECT_SOURCES}
    )

target_link_libraries(${PROJECT_ELF_FILE} m) # Math library required for sqrt(),...

ADD_CUSTOM_TARGET(
    flash
    COMMAND ${CMAKE_OBJCOPY} -Obinary ${PROJECT_ELF_FILE} ${PROJECT_BIN_FILE}
    COMMAND st-flash write ${PROJECT_BIN_FILE} 0x8000000
    COMMAND rm ${PROJECT_BIN_FILE}
    )

ADD_DEPENDENCIES(flash ${PROJECT_ELF_FILE})

ADD_CUSTOM_TARGET(clean_cmake
    COMMAND ${CMAKE_BUILD_TOOL} clean
    COMMAND git clean -d -f -x
    )

ADD_CUSTOM_TARGET(clean_all
    COMMAND git clean -d ${PROJECT_SOURCE_DIR} -f -f -x
    )

if(${DISCOVERY_BOARD_DISC1})
    set(OPENOCD_BOARD "board/stm32f429disc1.cfg")
else()
    set(OPENOCD_BOARD "board/stm32f429discovery.cfg")
endif()

ADD_CUSTOM_TARGET(
    debug
    COMMAND openocd -f ${OPENOCD_BOARD} >/dev/null 2>&1 & sleep 2
    COMMAND ${TARGET_TRIPLET}-gdb -quiet -tui -command=${CMAKE_CURRENT_LIST_DIR}/GDBCommands -se ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}.elf
    COMMAND killall -15 openocd
    )

ADD_DEPENDENCIES(debug flash)

STM32_SET_TARGET_PROPERTIES(${PROJECT_ELF_FILE})
STM32_ADD_HEX_BIN_TARGETS(${PROJECT_ELF_FILE})
STM32_PRINT_SIZE_OF_TARGETS(${PROJECT_ELF_FILE})

ADD_CUSTOM_TARGET(
    clean_lib
    DEPENDS cleanlib
    )

add_custom_command(OUTPUT cleanlib
    COMMAND ${CMAKE_COMMAND} -P "cmake/cleanall.cmake"
    )
