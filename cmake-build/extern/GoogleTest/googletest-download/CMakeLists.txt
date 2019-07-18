cmake_minimum_required(VERSION 3.13)

project(googletest-download NONE)

include(ExternalProject)

message("ExternalProject Add: googletest")
message("CMAKE_CURRENT_BINARY_DIR=/mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/cmake-build/extern/GoogleTest")


ExternalProject_Add(googletest
  GIT_REPOSITORY    https://github.com/google/googletest.git
  GIT_TAG           master
  GIT_CONFIG        http.proxy=  https.proxy=
  GIT_PROGRESS      ON
  SOURCE_DIR        "/mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/cmake-build/extern/GoogleTest/googletest-src"
  BINARY_DIR        "/mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/cmake-build/extern/GoogleTest/googletest-build"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)

message("GTest in finish...")
