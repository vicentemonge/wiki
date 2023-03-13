cmake_minimum_required(VERSION 3.18.0)

set(PROJECT_NAME "macro_function")
project("${PROJECT_NAME}")

### Fist locate superproject root and load common.cmake resources
# CMAKE_CURRENT_SOURCE_DIR is the top CMakeLists.txt path if a caller exists
set(PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}")
set(SUPERPROJECT_ROOT "${PROJECT_ROOT}/../..")
set(COMMON_CMAKE "${SUPERPROJECT_ROOT}/scripts/cmake/common.cmake")
INCLUDE(${COMMON_CMAKE})
####

macro(_MACRO_ argument)
  msg_status ("******************************variable = ${variable} content = ${content} external = ${external}")
  msg_status ("MACRO entry point             argument = ${argument} ${argument} = ${${argument}}")
  
  msg_print( "@ CALL set(\$\{argument\} \"abc\") set(${argument} \"abc\")")
  set(${argument} "abc")
  msg_warning("AFTER set values INSIDE MACRO argument = ${argument} ${argument} = ${${argument}}")
  
  msg_user( "@ CALL set(argument \"XXXXX\") => NO EFECT AT ALL")
  set(argument "XXXXX")
  msg_user   ("AFTER set values INSIDE MACRO argument = ${argument} ${argument} = ${${argument}}")
  
  msg_status("external = ${external}")
  set(${external} "earth")
  msg_status("external = ${external}")
  set(external "earth")
  msg_status("external = ${external}")

  msg_status ("******************************variable = ${variable} content = ${content} external = ${external}")
  msg_print("# EXIT MACRO")
endmacro()

function(_FUNCTION_ argument)
  msg_status ("******************************variable = ${variable} content = ${content} external = ${external}")
  msg_status ("FUNCTION entry point          argument = ${argument} ${argument} = ${${argument}}")
  
  msg_print( "@ CALL set(\$\{argument\} \"abc\") set(${argument} \"abc\")")
  set(${argument} "abc")
  msg_warning("AFTER set INSIDE FUNCTION     argument = ${argument} ${argument} = ${${argument}}")

  msg_print( "@ CALL set(argument \"abc\")")
  set(argument "abc")
  msg_warning("AFTER set INSIDE FUNCTION     argument = ${argument} ${argument} = ${${argument}}")

  msg_warning("external = ${external}")
  set(${external} "earth")
  msg_warning("external = ${external}")
  set(external "earth")
  msg_warning("external = ${external}")

  msg_status ("******************************variable = ${variable} content = ${content} external = ${external}")
  msg_print("# EXIT FUNCTION")
endfunction()

msg_trace("################################# MACRO:")
msg_trace("### Inside context is the same and all the changes take efect")
msg_trace("### arguments are \"named directions\" of variables and we can change values calling set(${variable} XXX)")

set(variable "content")
set(content "pep")
set(external "space")

msg_status ("BEFORE call MACRO             variable = ${variable} content = ${content} external = ${external}")
msg_print( "@ CALL _MACRO_(\$\{variable\}) _MACRO_(${variable})")
_MACRO_(${variable})
msg_error  ("AFTER call MACRO              variable = ${variable} content = ${content} external = ${external}")

set(variable "content")
set(content "pep")
set(external "space")

msg_status("BEFORE call MACRO              variable = ${variable} content = ${content} external = ${external}")
msg_print( "@ CALL _MACRO_(variable)")
_MACRO_(variable)
msg_error ("AFTER call MACRO               variable = ${variable} content = ${content} external = ${external}")


msg_trace("################################# FUNCTION:")
msg_trace("### the internal context is a copy of the calling context")
msg_trace("### but nothing change outside")

set(variable "content")
set(content "pep")
set(external "space")

msg_status ("BEFORE call FUNCTION          variable = ${variable} content = ${content} external = ${external}")
msg_print( "@ CALL _FUNCTION_(\$\{variable\}) _FUNCTION_(${variable})")
_FUNCTION_(${variable})
msg_user   ("AFTER call FUNCTION           variable = ${variable} content = ${content} external = ${external} => NO EFECT AT ALL")
msg_status("external = ${external}")

set(variable "content")
set(content "pep")
msg_status ("BEFORE call FUNCTION          variable = ${variable} content = ${content} external = ${external}")
msg_print( "@ CALL _FUNCTION_(variable)")
_FUNCTION_(variable)
msg_user   ("AFTER call FUNCTION           variable = ${variable} content = ${content} external = ${external} => NO EFECT AT ALL")
