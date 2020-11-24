# Download and unpack JugiMapFramework at configure time
configure_file(cmake/custom_jugimap_framework_download.in jugimap_framework-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
	RESULT_VARIABLE result
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/jugimap_framework-download
)
if(result)
	message(STATUS "CMake step for JugiMapFramework failed: ${result}")
	set(JUGIMAP_FRAMEWORK_ERROR TRUE)
endif()

execute_process(COMMAND ${CMAKE_COMMAND} --build .
	RESULT_VARIABLE result
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/jugimap_framework-download
)
if(result)
	message(STATUS "Build step for JugiMapFramework failed: ${result}")
	set(JUGIMAP_FRAMEWORK_ERROR TRUE)
endif()

if(JUGIMAP_FRAMEWORK_ERROR)
	message(FATAL_ERROR "Cannot download JugiMapFramework repository")
endif()
