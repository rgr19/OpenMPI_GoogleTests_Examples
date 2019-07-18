
if(DO_GTEST)

# Setup testing


cmake_minimum_required(VERSION 3.13)

macro(add_gtest TESTNAME SOURCES)
  project(${TESTNAME} LANGUAGES C CXX)
  add_executable(${TESTNAME} ${SOURCES})
    target_link_libraries(${TESTNAME} gtest gmock gtest_main)
    add_test(NAME ${TESTNAME} COMMAND ${TESTNAME})
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests COMPILE_DEFINITIONS DO_GTEST=1)
    config_test_output(${TESTNAME})
endmacro()

macro(add_gtest_mpi TESTNAME SOURCES)
  project(${TESTNAME} LANGUAGES C CXX)
  add_executable_mpi(${TESTNAME} ${SOURCES})
    target_link_libraries(${TESTNAME} gtest gmock gtest_main)
    add_test(NAME ${TESTNAME} COMMAND ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3 ${TESTNAME})
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests COMPILE_DEFINITIONS DO_GTEST=1)
    config_test_output(${TESTNAME})
endmacro()

macro(add_gtest_mpi_custom TESTNAME SOURCES)
  project(${TESTNAME} LANGUAGES C CXX)
  add_executable_mpi(${TESTNAME} ${SOURCES})
    target_link_libraries(${TESTNAME} gtest gmock gtest_main)
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests COMPILE_DEFINITIONS DO_GTEST=1)
    config_test_output(${TESTNAME})
  
    add_custom_command(TARGET ${TESTNAME} 
                       POST_BUILD COMMAND 
                      OPAL_PREFIX=$ENV{OPAL_PREFIX} 
                      LD_LIBRARY_PATH=$ENV{LD_LIBRARY_PATH}
                      ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3 $<TARGET_FILE:${TESTNAME}>)
endmacro()


macro(add_mpi_test TESTNAME SOURCES)
  add_executable_mpi(${TESTNAME} ${SOURCES})
    add_test(NAME ${TESTNAME} COMMAND ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3 ${TESTNAME})
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests COMPILE_DEFINITIONS DO_MPI_TEST=1)
    config_test_output(${TESTNAME})

endmacro()


message("CURRENT PROJECT = ${PROJECT_NAME}")
message("CMAKE_CURRENT_BINARY_DIR = ${CMAKE_CURRENT_BINARY_DIR}")

#set(CMAKE_CURRENT_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/cmake-build)
#set(CMAKE_)
#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED TRUE)




enable_testing()
add_gtest(test_gtest test_gtest.cpp)

add_gtest_mpi(test_gtest_mpi.ompi test_gtest_mpi.cpp)
add_gtest_mpi_custom(test_gtest_mpi_listener.ompi test_gtest_mpi_listener.cpp)


endif(DO_GTEST)

