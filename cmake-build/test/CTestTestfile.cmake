# CMake generated Testfile for 
# Source directory: /mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/test
# Build directory: /mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/cmake-build/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_gtest "/mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/bin/test/debug/test_gtest")
add_test(test_gtest_mpi.ompi "/mnt/c/My/W/W.priv/Examples/OpenMPI_GoogleTests_Examples/extern/OpenMPI/bin/mpiexec" "-n" "3" "test_gtest_mpi.ompi")
