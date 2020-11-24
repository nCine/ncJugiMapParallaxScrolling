set(PACKAGE_NAME "ncJugiMapParallaxScrolling")
set(PACKAGE_EXE_NAME "ncjugimap_parallaxscrolling")
set(PACKAGE_VENDOR "Jugilus")
set(PACKAGE_COPYRIGHT "Copyright ©2020 ${PACKAGE_VENDOR}")
set(PACKAGE_DESCRIPTION "A nCine port of the JugiMap Parallax Scrolling demo by Jugilus")
set(PACKAGE_HOMEPAGE "http://jugimap.com")
set(PACKAGE_REVERSE_DNS "com.jugimap.parallaxscrolling.ncine")

set(PACKAGE_INCLUDE_DIRS src/)

set(PACKAGE_SOURCES
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

function(callback_start)
	if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
		include(custom_jugimap_framework)
		set(JUGIMAP_FRAMEWORK_SRC "${CMAKE_BINARY_DIR}/jugimap_framework-src")
		set(JUGIMAP_FRAMEWORK_DEST "${CMAKE_SOURCE_DIR}/src")
		if(IS_DIRECTORY ${JUGIMAP_FRAMEWORK_SRC})
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/framework_c++/jugimap DESTINATION ${JUGIMAP_FRAMEWORK_DEST})
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/framework_c++/jugimapNCINE DESTINATION ${JUGIMAP_FRAMEWORK_DEST})
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/framework_c++/utf8cpp DESTINATION ${JUGIMAP_FRAMEWORK_DEST})
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/examples_c++/ParallaxScrolling/jugiApp DESTINATION ${JUGIMAP_FRAMEWORK_DEST})
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/examples_c++/ParallaxScrolling/ParallaxScrolling_nCine/ DESTINATION ${JUGIMAP_FRAMEWORK_DEST})
		endif()
	endif()
endfunction()

function(callback_before_target)
	if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android" AND IS_DIRECTORY ${PACKAGE_DATA_DIR})
		set(JUGIMAP_FRAMEWORK_SRC "${CMAKE_BINARY_DIR}/jugimap_framework-src")
		if(IS_DIRECTORY ${JUGIMAP_FRAMEWORK_SRC})
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/examples_c++/ParallaxScrolling/media/fonts DESTINATION ${PACKAGE_DATA_DIR}/data/media)
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/examples_c++/ParallaxScrolling/media/graphics DESTINATION ${PACKAGE_DATA_DIR}/data/media)
			file(COPY ${JUGIMAP_FRAMEWORK_SRC}/examples_c++/ParallaxScrolling/media/maps DESTINATION ${PACKAGE_DATA_DIR}/data/media)
		endif()

		file(GLOB MEDIA_FONTS RELATIVE ${PACKAGE_DATA_DIR} ${PACKAGE_DATA_DIR}/data/media/fonts/*)
		file(GLOB MEDIA_GRAPHICS RELATIVE ${PACKAGE_DATA_DIR} ${PACKAGE_DATA_DIR}/data/media/graphics/*)
		file(GLOB MEDIA_MAPS RELATIVE ${PACKAGE_DATA_DIR} ${PACKAGE_DATA_DIR}/data/media/maps/*)
		set(PACKAGE_ANDROID_ASSETS ${MEDIA_FONTS} ${MEDIA_GRAPHICS} ${MEDIA_MAPS} CACHE STRING "" FORCE)
	endif()
endfunction()
