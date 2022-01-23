set(JUGIMAP_FRAMEWORK_REPOSITORY "https://github.com/encelo/JugimapFramework")
set(JUGIMAP_FRAMEWORK_VERSION_TAG "nCine")
# Download release archive (TRUE) or Git repository (FALSE)
set(JUGIMAP_FRAMEWORK_DOWNLOAD_ARCHIVE TRUE)

if(JUGIMAP_FRAMEWORK_DOWNLOAD_ARCHIVE AND ${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.18.0")
	# Strip the initial "v" character from the version tag
	string(REGEX MATCH "^v[0-9]" JUGIMAP_FRAMEWORK_STRIP_VERSION ${JUGIMAP_FRAMEWORK_VERSION_TAG})
	if(JUGIMAP_FRAMEWORK_STRIP_VERSION STREQUAL "")
		set(JUGIMAP_FRAMEWORK_VERSION_TAG_DIR ${JUGIMAP_FRAMEWORK_VERSION_TAG})
	else()
		string(SUBSTRING ${JUGIMAP_FRAMEWORK_VERSION_TAG} 1 -1 JUGIMAP_FRAMEWORK_VERSION_TAG_DIR)
	endif()

	set(JUGIMAP_FRAMEWORK_SOURCE_DIR ${CMAKE_BINARY_DIR}/JugimapFramework-${JUGIMAP_FRAMEWORK_VERSION_TAG_DIR})
else()
	set(JUGIMAP_FRAMEWORK_SOURCE_DIR ${CMAKE_BINARY_DIR}/jugimap_framework-src)
endif()

if(JUGIMAP_FRAMEWORK_DOWNLOAD_ARCHIVE AND ${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.18.0")
	if(IS_DIRECTORY ${CMAKE_BINARY_DIR}/JugimapFramework-${JUGIMAP_FRAMEWORK_VERSION_TAG_DIR})
		message(STATUS "JugiMap Framework release file \"${JUGIMAP_FRAMEWORK_VERSION_TAG}\" has been already downloaded")
	else()
		file(DOWNLOAD ${JUGIMAP_FRAMEWORK_REPOSITORY}/archive/${JUGIMAP_FRAMEWORK_VERSION_TAG}.tar.gz
			${CMAKE_BINARY_DIR}/${JUGIMAP_FRAMEWORK_VERSION_TAG}.tar.gz STATUS result)

		list(GET result 0 result_code)
		if(result_code)
			message(FATAL_ERROR "Cannot download JugiMap Framework release file ${JUGIMAP_FRAMEWORK_VERSION_TAG}")
		else()
			message(STATUS "Downloaded JugiMap Framework release file \"${JUGIMAP_FRAMEWORK_VERSION_TAG}\"")
			file(ARCHIVE_EXTRACT INPUT ${CMAKE_BINARY_DIR}/${JUGIMAP_FRAMEWORK_VERSION_TAG}.tar.gz DESTINATION ${CMAKE_BINARY_DIR})
			file(REMOVE ${CMAKE_BINARY_DIR}/${JUGIMAP_FRAMEWORK_VERSION_TAG}.tar.gz)
		endif()
	endif()
else()
	# Download JugiMapFramework repository at configure time
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
endif()
