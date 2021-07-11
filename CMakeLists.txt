set(NCPROJECT_NAME "ncJugiMapParallaxScrolling")
set(NCPROJECT_EXE_NAME "ncjugimap_parallaxscrolling")
set(NCPROJECT_VENDOR "Jugilus")
set(NCPROJECT_COPYRIGHT "Copyright ©2020-2021 ${NCPROJECT_VENDOR}")
set(NCPROJECT_DESCRIPTION "A nCine port of the JugiMap Parallax Scrolling demo by Jugilus")
set(NCPROJECT_HOMEPAGE "http://jugimap.com")
set(NCPROJECT_REVERSE_DNS "com.jugimap.parallaxscrolling.ncine")

set(NCPROJECT_INCLUDE_DIRS src/)

set(NCPROJECT_SOURCES
	src/jugiApp/app.h
	src/jugiApp/app.cpp
	src/jugiApp/scene.h
	src/jugiApp/scene.cpp

	src/jugimap/jmAnimationCommon.h
	src/jugimap/jmAnimationCommon.cpp
	src/jugimap/jmApp.h
	src/jugimap/jmApp.cpp
	src/jugimap/jmCamera.h
	src/jugimap/jmCamera.cpp
	src/jugimap/jmCollision.h
	src/jugimap/jmCollision.cpp
	src/jugimap/jmColor.h
	src/jugimap/jmColor.cpp
	src/jugimap/jmCommon.h
	src/jugimap/jmCommon.cpp
	src/jugimap/jmCommonFunctions.h
	src/jugimap/jmCommonFunctions.cpp
	src/jugimap/jmDrawing.h
	src/jugimap/jmDrawing.cpp
	src/jugimap/jmFont.h
	src/jugimap/jmFont.cpp
	src/jugimap/jmFrameAnimation.h
	src/jugimap/jmFrameAnimation.cpp
	src/jugimap/jmGlobal.h
	src/jugimap/jmGlobal.cpp
	src/jugimap/jmGuiCommon.h
	src/jugimap/jmGuiCommon.cpp
	src/jugimap/jmGuiText.h
	src/jugimap/jmGuiText.cpp
	src/jugimap/jmGuiTextWidgets.h
	src/jugimap/jmGuiTextWidgets.cpp
	src/jugimap/jmGuiWidgetsA.h
	src/jugimap/jmGuiWidgetsA.cpp
	src/jugimap/jmInput.h
	src/jugimap/jmInput.cpp
	src/jugimap/jmLayers.h
	src/jugimap/jmLayers.cpp
	src/jugimap/jmMapBinaryLoader.h
	src/jugimap/jmMapBinaryLoader.cpp
	src/jugimap/jmMap.h
	src/jugimap/jmMap.cpp
	src/jugimap/jmObjectFactory.h
	src/jugimap/jmObjectFactory.cpp
	src/jugimap/jmScene.h
	src/jugimap/jmScene.cpp
	src/jugimap/jmSourceGraphics.h
	src/jugimap/jmSourceGraphics.cpp
	src/jugimap/jmSprites.h
	src/jugimap/jmSprites.cpp
	src/jugimap/jmStreams.h
	src/jugimap/jmStreams.cpp
	src/jugimap/jmTimelineAnimation.h
	src/jugimap/jmTimelineAnimation.cpp
	src/jugimap/jmTimelineAnimationInstance.h
	src/jugimap/jmTimelineAnimationInstance.cpp
	src/jugimap/jmUtilities.h
	src/jugimap/jmUtilities.cpp
	src/jugimap/jmVectorShapes.h
	src/jugimap/jmVectorShapes.cpp
	src/jugimap/jmVectorShapesUtilities.h
	src/jugimap/jmVectorShapesUtilities.cpp
	src/jugimap/jugimap.h

	src/jugimapNCINE/jmNCine.h
	src/jugimapNCINE/jmNCine.cpp

	src/main.h
	src/main.cpp
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

function(callback_start)
	if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
		include(custom_jugimap_framework)
		set(JUGIMAP_FRAMEWORK_SOURCE_DIR ${JUGIMAP_FRAMEWORK_SOURCE_DIR} PARENT_SCOPE)
		if(IS_DIRECTORY ${JUGIMAP_FRAMEWORK_SOURCE_DIR})
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/framework_c++/jugimap DESTINATION ${CMAKE_SOURCE_DIR}/src)
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/framework_c++/jugimapNCINE DESTINATION ${CMAKE_SOURCE_DIR}/src)
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/framework_c++/utf8cpp DESTINATION ${CMAKE_SOURCE_DIR}/src)
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/examples_c++/ParallaxScrolling/jugiApp DESTINATION ${CMAKE_SOURCE_DIR}/src)
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/examples_c++/ParallaxScrolling/ParallaxScrolling_nCine/ DESTINATION ${CMAKE_SOURCE_DIR}/src)
		endif()
	endif()
endfunction()

function(callback_before_target)
	if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android" AND IS_DIRECTORY ${NCPROJECT_DATA_DIR})
		if(IS_DIRECTORY ${JUGIMAP_FRAMEWORK_SOURCE_DIR})
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/examples_c++/ParallaxScrolling/media/fonts DESTINATION ${NCPROJECT_DATA_DIR}/data/media)
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/examples_c++/ParallaxScrolling/media/graphics DESTINATION ${NCPROJECT_DATA_DIR}/data/media)
			file(COPY ${JUGIMAP_FRAMEWORK_SOURCE_DIR}/examples_c++/ParallaxScrolling/media/maps DESTINATION ${NCPROJECT_DATA_DIR}/data/media)
		endif()

		file(GLOB MEDIA_FONTS RELATIVE ${NCPROJECT_DATA_DIR} ${NCPROJECT_DATA_DIR}/data/media/fonts/*)
		file(GLOB MEDIA_GRAPHICS RELATIVE ${NCPROJECT_DATA_DIR} ${NCPROJECT_DATA_DIR}/data/media/graphics/*)
		file(GLOB MEDIA_MAPS RELATIVE ${NCPROJECT_DATA_DIR} ${NCPROJECT_DATA_DIR}/data/media/maps/*)
		set(NCPROJECT_ANDROID_ASSETS ${MEDIA_FONTS} ${MEDIA_GRAPHICS} ${MEDIA_MAPS} CACHE STRING "" FORCE)
	endif()
endfunction()

# Temporary fix until source code is updated
function(callback_end)
	if(NCPROJECT_DEFAULT_DATA_DIR)
		target_compile_definitions(${NCPROJECT_EXE_NAME} PRIVATE "PACKAGE_DEFAULT_DATA_DIR=\"${NCPROJECT_DEFAULT_DATA_DIR}\"")
	endif()
endfunction()

# Don't edit beyond this line
if(CMAKE_SYSTEM_NAME STREQUAL "Android")
	return()
endif()

cmake_minimum_required(VERSION 3.13)
project(${NCPROJECT_NAME})

find_path(NCPROJECT_DIR cmake/project_main.cmake
	PATHS ${nCine_DIR} $ENV{NCINE_DIR}
	PATH_SUFFIXES project ../project ../../../project ../../../share/ncine/project
	NO_CMAKE_FIND_ROOT_PATH # For Emscripten
	DOC "Path to the nCine template project scripts")

if(IS_DIRECTORY ${NCPROJECT_DIR})
	include(${NCPROJECT_DIR}/cmake/project_main.cmake)
else()
	message(FATAL_ERROR "Directory \"${NCPROJECT_DIR}\" does not exist")
endif()
