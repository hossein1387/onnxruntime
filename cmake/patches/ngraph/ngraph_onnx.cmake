set(BINARY_DIR "${prebuilt_ONNX_BINARY_DIR}")
set(ONNX_INCLUDE_DIR ${BINARY_DIR})
set(ONNX_SOURCE_INCLUDE_DIR "${prebuilt_ONNX_SOURCE_DIR}/onnx")
include_directories("${ONNX_SOURCE_INCLUDE_DIR}")
set(ONNX_PROTO_INCLUDE_DIR ${ONNX_INCLUDE_DIR})
set(ONNX_LIBRARY ${BINARY_DIR}/libonnx.a)
set(ONNX_PROTO_LIBRARY ${BINARY_DIR}/libonnx_proto.a)
set(ONNX_LIBRARIES ${ONNX_LIBRARY} ${ONNX_PROTO_LIBRARY})

if (NOT TARGET onnx::libonnx)
    add_library(onnx::libonnx UNKNOWN IMPORTED)
    set_target_properties(onnx::libonnx PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${ONNX_INCLUDE_DIR}
            IMPORTED_LOCATION ${ONNX_LIBRARY}
            INCLUDE_DIRECTORIES "${ONNX_SOURCE_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS ONNX_ML=1)
endif()

if (NOT TARGET onnx::libonnx_proto)
    add_library(onnx::libonnx_proto UNKNOWN IMPORTED)
    set_target_properties(onnx::libonnx_proto PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${ONNX_PROTO_INCLUDE_DIR}
            IMPORTED_LOCATION ${ONNX_PROTO_LIBRARY}
            INCLUDE_DIRECTORIES "${ONNX_SOURCE_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS ONNX_ML=1)
endif()
add_library(ext_onnx UNKNOWN IMPORTED)
add_dependencies(ext_onnx onnx::libonnx)
