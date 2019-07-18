

function(set_build_type)

  if(DEFINED ARGN1)
    set(default_build_type "${ARGN1}")
  else()
    set(default_build_type "Release")
  endif()

  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
       STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
                "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
  endif()

endfunction()

macro(get_runtime_output_dir TARGET)
  
  if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    get_target_property(RUNTIME_OUTPUT_DIR ${TARGET} RUNTIME_OUTPUT_DIRECTORY_DEBUG)
  elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
    get_target_property(RUNTIME_OUTPUT_DIR ${TARGET} RUNTIME_OUTPUT_DIRECTORY_RELEASE)
  elseif(CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
    get_target_property(RUNTIME_OUTPUT_DIR ${TARGET} RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL)
  elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    get_target_property(RUNTIME_OUTPUT_DIR ${TARGET} RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO)
  else()
    get_target_property(RUNTIME_OUTPUT_DIR ${TARGET} RUNTIME_OUTPUT_DIRECTORY)
  endif()

endmacro()

macro(config_bin_output TARGET)
				set(RUNTIME_DIR "${CMAKE_SOURCE_DIR}/bin/target")
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY                "${RUNTIME_DIR}" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG          "${RUNTIME_DIR}/debug" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE        "${RUNTIME_DIR}/release" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${RUNTIME_DIR}/relwithdebinfo" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL     "${RUNTIME_DIR}/minsizerel" )
endmacro(config_bin_output)

macro(config_test_output TARGET)
				set(RUNTIME_DIR "${CMAKE_SOURCE_DIR}/bin/test")
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY                "${RUNTIME_DIR}" )
				set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG          "${RUNTIME_DIR}/debug" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE        "${RUNTIME_DIR}/release" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${RUNTIME_DIR}/relwithdebinfo" )
        set_target_properties( ${TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL     "${RUNTIME_DIR}/minsizerel" )
endmacro(config_test_output)

function(JOIN OUT GLUE)
  SET(TEMP)
  foreach(arg IN ITEMS ${ARGN})
	STRING(STRIP "${arg}" arg)
  	SET(TEMP "${TEMP} ${GLUE}${arg}")
  endforeach()
  STRING(STRIP "${TEMP}" TEMP)
  SET(${OUT} "${TEMP}" PARENT_SCOPE)
endfunction()

# External libraries which need to be built.
#add_subdirectory ( ${CMAKE_SOURCE_DIR}/extern/GoogleTest extern/GoogleTest )
#set_target_properties(gtest PROPERTIES FOLDER extern)
#set_target_properties(gtest_main PROPERTIES FOLDER extern)
#set_target_properties(gmock PROPERTIES FOLDER extern)
#set_target_properties(gmock_main PROPERTIES FOLDER extern)


#NEVER SET ROOT, it will remove all paths to ./cmake
#set(CMAKE_ROOT ${CMAKE_SOURCE_DIR})


#list(APPEND CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}/external/embree2")
#list(APPEND CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}/external/sdl2")
#list(APPEND CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}/external/glew")
#list(APPEND CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}/external/glm")


#message("install: DIRECTORY ${CMAKE_SOURCE_DIR}/extern/OpenMPI DESTINATION ${CMAKE_BINARY_DIR}/extern/OpenMPI")

#install(DIRECTORY ${CMAKE_SOURCE_DIR}/extern/OpenMPI DESTINATION ${CMAKE_BINARY_DIR}/extern/OpenMPI )
#executes after doing: make install

  #if(NOT EXISTS ${CMAKE_BINARY_DIR}/${OpenMPI_DIR})
  #  add_custom_command(TARGET ${FAKE_TARGET_OMPI} PRE_BUILD COMMAND cp ${CMAKE_SOURCE_DIR}/${OpenMPI_DIR} ${RUNTIME_OUTPUT_DIRECTORY}/${OpenMPI_DIR} -Rfn)
  #endif()
