# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/alxhoff/git/GitHub/bluepill

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/alxhoff/git/GitHub/bluepill/build

# Utility rule file for STM32F1_bluepill.elf.hex.

# Include the progress variables for this target.
include CMakeFiles/STM32F1_bluepill.elf.hex.dir/progress.make

CMakeFiles/STM32F1_bluepill.elf.hex: STM32F1_bluepill.elf
	/usr/bin/arm-none-eabi-objcopy -Oihex STM32F1_bluepill.elf STM32F1_bluepill.elf.hex

STM32F1_bluepill.elf.hex: CMakeFiles/STM32F1_bluepill.elf.hex
STM32F1_bluepill.elf.hex: CMakeFiles/STM32F1_bluepill.elf.hex.dir/build.make

.PHONY : STM32F1_bluepill.elf.hex

# Rule to build all files generated by this target.
CMakeFiles/STM32F1_bluepill.elf.hex.dir/build: STM32F1_bluepill.elf.hex

.PHONY : CMakeFiles/STM32F1_bluepill.elf.hex.dir/build

CMakeFiles/STM32F1_bluepill.elf.hex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/STM32F1_bluepill.elf.hex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/STM32F1_bluepill.elf.hex.dir/clean

CMakeFiles/STM32F1_bluepill.elf.hex.dir/depend:
	cd /home/alxhoff/git/GitHub/bluepill/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alxhoff/git/GitHub/bluepill /home/alxhoff/git/GitHub/bluepill /home/alxhoff/git/GitHub/bluepill/build /home/alxhoff/git/GitHub/bluepill/build /home/alxhoff/git/GitHub/bluepill/build/CMakeFiles/STM32F1_bluepill.elf.hex.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/STM32F1_bluepill.elf.hex.dir/depend
