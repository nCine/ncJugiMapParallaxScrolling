# Download and unpack JugiMapAPI at configure time
configure_file(cmake/custom_jugimapapi_download.in jugimapapi-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
	RESULT_VARIABLE result
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/jugimapapi-download
)
if(result)
	message(STATUS "CMake step for JugiMapAPI failed: ${result}")
	set(JUGIMAPAPI_ERROR TRUE)
endif()

execute_process(COMMAND ${CMAKE_COMMAND} --build .
	RESULT_VARIABLE result
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/jugimapapi-download
)
if(result)
	message(STATUS "Build step for JugiMapAPI failed: ${result}")
	set(JUGIMAPAPI_ERROR TRUE)
endif()

if(JUGIMAPAPI_ERROR)
	message(FATAL_ERROR "Cannot download JugiMapAPI repository")
endif()
