#SET(FAKE_TARGET_OMPI fakeTargetOMPI)

function(assert_ompi)
  message("OMPI_FOUND=${OMPI_FOUND}")
  if(NOT OMPI_FOUND)
    message(FATAL_ERROR "ERROR: OMPI is not set assert_ompi found")
  endif()
endfunction()

macro(setup_openmpi)
 unset(OMPI_FOUND CACHE)


  if(DEFINED ARGN1)
    set(OpenMPI_DIR ${ARGN1})
  else()
    set(OpenMPI_DIR ${CMAKE_SOURCE_DIR}/extern/OpenMPI)
  endif()

  message("OpenMPI_DIR = ${OpenMPI_DIR}")

  set(ENV{OPAL_PREFIX} ${OpenMPI_DIR})
  set(ENV{LD_LIBRARY_PATH} ${OpenMPI_DIR}/lib)

  set(MPI_CXX_COMPILER ${OpenMPI_DIR}/bin/mpicxx)
  set(MPI_C_COMPILER ${OpenMPI_DIR}/bin/mpicc)
  set(MPI_LIB_PATH ${OpenMPI_DIR}/lib)
  set(MPI_INCLUDE_PATH ${OpenMPI_DIR}/include)
  set(MPIEXEC_EXECUTABLE ${OpenMPI_DIR}/bin/mpiexec)
  set(MPIEXEC_NUMPROC_FLAG "-n")
  set(MPIEXEC ${MPIEXEC_EXECUTABLE})

  execute_process(COMMAND ${MPI_C_COMPILER} --showme:compile OUTPUT_VARIABLE MPI_C_COMPILE_FLAGS)
  execute_process(COMMAND ${MPI_CXX_COMPILER} --showme:compile OUTPUT_VARIABLE MPI_CXX_COMPILE_FLAGS)
  execute_process(COMMAND ${MPI_C_COMPILER} --showme:link OUTPUT_VARIABLE MPI_C_LINK_FLAGS)
  execute_process(COMMAND ${MPI_CXX_COMPILER} --showme:link OUTPUT_VARIABLE MPI_CXX_LINK_FLAGS)
  execute_process(COMMAND ${MPI_CXX_COMPILER} --showme:libs OUTPUT_VARIABLE MPI_LIBRARIES)

  JOIN(MPI_LIBRARIES -l "${MPI_LIBRARIES}")

  STRING(STRIP ${MPI_CXX_LINK_FLAGS} MPI_CXX_LINK_FLAGS)
  STRING(STRIP ${MPI_CXX_COMPILE_FLAGS} MPI_CXX_COMPILE_FLAGS)

  MESSAGE(ENV{OPAL_PREFIX=$ENV{OPAL_PREFIX})
  MESSAGE(ENV{LD_LIBRARY_PATH=$ENV{LD_LIBRARY_PATH})
  MESSAGE(MPI_C_COMPILE_FLAGS=${MPI_C_COMPILE_FLAGS})
  MESSAGE(MPI_CXX_COMPILE_FLAGS=${MPI_CXX_COMPILE_FLAGS})
  MESSAGE(MPI_C_LINK_FLAGS=${MPI_C_LINK_FLAGS})
  MESSAGE(MPI_CXX_LINK_FLAGS=${MPI_CXX_LINK_FLAGS})
  MESSAGE(MPI_LIBRARIES=${MPI_LIBRARIES})

  #link_directories(${MPI_LIB_PATH})
  #include_directories(${MPI_INCLUDE_PATH})

  option(OMPI_FOUND "Set flag that OMPI is found now" ON)

  message("OMPI_FOUND=${OMPI_FOUND}")
endmacro()


macro(add_executable_mpi TARGET SOURCES)
  assert_ompi()

  if(NOT DEFINED PROJECT_NAME)
    message("OMPI project not defined. Set PROJECT(${TARGET})...")
    PROJECT(${TARGET} )
  endif()

  add_executable(${TARGET} ${SOURCES})
  #if(DEFINED FAKE_TARGET_OMPI)
  #  add_dependencies(${TARGET} ${FAKE_TARGET_OMPI})
  #endif()

  # Attach directories
  target_link_directories(${TARGET} PRIVATE ${MPI_LIB_PATH})
  target_include_directories(${TARGET} PRIVATE ${MPI_INCLUDE_PATH} )

  # Attach openmpi flags
  target_compile_options(${TARGET} PRIVATE ${MPI_CXX_COMPILE_FLAGS})
  target_link_libraries(${TARGET} ${MPI_LIBRARIES} ${MPI_CXX_LINK_FLAGS})

  set_target_properties(${TARGET} PROPERTIES FOLDER extern)

  target_compile_definitions(${TARGET} PRIVATE
    OPAL_PREFIX=$ENV{OPAL_PREFIX}
    LD_LIBRARY_PATH=$ENV{LD_LIBRARY_PATH}
    )

endmacro()


