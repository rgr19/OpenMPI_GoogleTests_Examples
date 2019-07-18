
cmake_minimum_required(VERSION 3.13)


option(DO_GTEST "Use google tests to perform bunch of tests..." ON)

option(DO_TARGET "Build targets from src dir..." ON)

option(DO_OMPI "Build targets/tests for OpenMPI..." ON)



list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(CMakeCommon)


set(EXTERN_DIRS "${CMAKE_SOURCE_DIR}/extern")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set ( CMAKE_EXPORT_COMPILE_COMMANDS ON )
set ( CMAKE_BUILD_TYPE DEBUG )


set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)



#Default build type
set_build_type()



# OpenMPI setup
if(DO_OMPI)

  include(OpenMPI)

  setup_openmpi()

  assert_ompi()

endif(DO_OMPI)

# Setup Target


if(DO_TARGET)
  message("DO_TARGET is set...")
  add_subdirectory(src)

else(DO_TARGET)
  message("DO_TARGET not set...")

endif(DO_TARGET)


# Setup testing

if(DO_GTEST)
  message("DO_GTEST is set...")
	add_subdirectory(extern/GoogleTest)
  add_subdirectory(test)

else(DO_GTEST)
  message("DO_GTEST not set...")

endif(DO_GTEST)

unset(DO_GTEST CACHE)







