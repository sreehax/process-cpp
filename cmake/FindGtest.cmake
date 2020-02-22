include(ExternalProject)
include(FindPackageHandleStandardArgs)

#gtest
set(GTEST_INCLUDE_DIR /usr/include)

#gmock
set(GMOCK_INCLUDE_DIR /usr/include)

set(GMOCK_PREFIX gmock)
set(GMOCK_BINARY_DIR ${CMAKE_BINARY_DIR}/${GMOCK_PREFIX}/libs)
set(GTEST_BINARY_DIR ${GMOCK_BINARY_DIR}/gtest)

set(GTEST_CMAKE_ARGS "")
if (${MIR_IS_CROSS_COMPILING})
    set(GTEST_CMAKE_ARGS
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_MODULE_PATH}/LinuxCrossCompile.cmake)
endif()

ExternalProject_Add(
    GMock
    #where to build in source tree
    PREFIX ${GMOCK_PREFIX}
    #where the source is external to the project
    SOURCE_DIR ${GMOCK_INSTALL_DIR}
    #forward the compilers to the subproject so cross-arch builds work
    CMAKE_ARGS ${GTEST_CMAKE_ARGS}
    BINARY_DIR ${GMOCK_BINARY_DIR}

    #we don't need to install, so skip
    INSTALL_COMMAND ""
)

set(GMOCK_LIBRARY ${GMOCK_BINARY_DIR}/libgmock.so)
set(GMOCK_MAIN_LIBRARY ${GMOCK_BINARY_DIR}/libgmock_main.so)
set(GMOCK_BOTH_LIBRARIES ${GMOCK_LIBRARY} ${GMOCK_MAIN_LIBRARY})
set(GTEST_LIBRARY ${GTEST_BINARY_DIR}/libgtest.so)
set(GTEST_MAIN_LIBRARY ${GTEST_BINARY_DIR}/libgtest_main.so)
set(GTEST_BOTH_LIBRARIES ${GTEST_LIBRARY} ${GTEST_MAIN_LIBRARY})
set(GTEST_ALL_LIBRARIES ${GTEST_BOTH_LIBRARIES} ${GMOCK_BOTH_LIBRARIES})

find_package_handle_standard_args(GTest  DEFAULT_MSG
                                    GMOCK_INCLUDE_DIR
                                    GTEST_INCLUDE_DIR)
