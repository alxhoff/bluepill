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

# Utility rule file for clean_lib.

# Include the progress variables for this target.
include CMakeFiles/clean_lib.dir/progress.make

CMakeFiles/clean_lib: cleanlib


cleanlib:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/alxhoff/git/GitHub/bluepill/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating cleanlib"
	/usr/bin/cmake -P cmake/cleanall.cmake

clean_lib: CMakeFiles/clean_lib
clean_lib: cleanlib
clean_lib: CMakeFiles/clean_lib.dir/build.make

.PHONY : clean_lib

# Rule to build all files generated by this target.
CMakeFiles/clean_lib.dir/build: clean_lib

.PHONY : CMakeFiles/clean_lib.dir/build

CMakeFiles/clean_lib.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/clean_lib.dir/cmake_clean.cmake
.PHONY : CMakeFiles/clean_lib.dir/clean

CMakeFiles/clean_lib.dir/depend:
	cd /home/alxhoff/git/GitHub/bluepill/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alxhoff/git/GitHub/bluepill /home/alxhoff/git/GitHub/bluepill /home/alxhoff/git/GitHub/bluepill/build /home/alxhoff/git/GitHub/bluepill/build /home/alxhoff/git/GitHub/bluepill/build/CMakeFiles/clean_lib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/clean_lib.dir/depend
