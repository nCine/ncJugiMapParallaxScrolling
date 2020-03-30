set(PACKAGE_NAME "ncJugiMapParallaxScrolling")
set(PACKAGE_EXE_NAME "ncjugimapparallaxscrolling")
set(PACKAGE_VENDOR "Angelo Theodorou and Jugilus")
set(PACKAGE_COPYRIGHT "Copyright ©2020 ${PACKAGE_VENDOR}")
set(PACKAGE_DESCRIPTION "A nCine port of the JugiMap Parallax Scrolling test by Jugilus")
set(PACKAGE_HOMEPAGE "https://ncine.github.io")
set(PACKAGE_REVERSE_DNS "io.github.ncine.ncjugimapparallaxscrolling")

set(PACKAGE_INCLUDE_DIRS src/)

set(PACKAGE_SOURCES
	src/engineIndependent/parallaxScene.h
	src/engineIndependent/parallaxScene.cpp

	src/jugimap/jmCamera.cpp
	src/jugimap/jmCamera.h
	src/jugimap/jmCollision.cpp
	src/jugimap/jmCollision.h
	src/jugimap/jmCommon.cpp
	src/jugimap/jmCommonFunctions.cpp
	src/jugimap/jmCommonFunctions.h
	src/jugimap/jmCommon.h
	src/jugimap/jmDrawing.cpp
	src/jugimap/jmDrawing.h
	src/jugimap/jmFrameAnimation.cpp
	src/jugimap/jmFrameAnimation.h
	src/jugimap/jmGlobal.cpp
	src/jugimap/jmGlobal.h
	src/jugimap/jmLayers.cpp
	src/jugimap/jmLayers.h
	src/jugimap/jmMapBinaryLoader.cpp
	src/jugimap/jmMapBinaryLoader.h
	src/jugimap/jmMap.cpp
	src/jugimap/jmMap.h
	src/jugimap/jmObjectFactory.cpp
	src/jugimap/jmObjectFactory.h
	src/jugimap/jmScene.h
	src/jugimap/jmSceneManager.cpp
	src/jugimap/jmSceneManager.h
	src/jugimap/jmSourceGraphics.cpp
	src/jugimap/jmSourceGraphics.h
	src/jugimap/jmSprites.cpp
	src/jugimap/jmSprites.h
	src/jugimap/jmStreams.cpp
	src/jugimap/jmStreams.h
	src/jugimap/jmText.cpp
	src/jugimap/jmText.h
	src/jugimap/jmTween.cpp
	src/jugimap/jmTween.h
	src/jugimap/jmUtilities.cpp
	src/jugimap/jmUtilities.h
	src/jugimap/jmVectorShapes.cpp
	src/jugimap/jmVectorShapes.h
	src/jugimap/jmVectorShapesUtilities.cpp
	src/jugimap/jmVectorShapesUtilities.h
	src/jugimap/jugimap.h

	src/jugimapNCINE/jmNCine.h
	src/jugimapNCINE/jmNCine.cpp

	src/main.h
	src/main.cpp
	src/sceneNCINE.h
	src/sceneNCINE.cpp
)

function(callback_start)
	if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
		include(custom_jugimapapi)
		set(JUGIMAPAPI_SRC "${CMAKE_BINARY_DIR}/jugimapapi-src")
		set(JUGIMAPAPI_DEST "${CMAKE_SOURCE_DIR}/src")
		if(IS_DIRECTORY ${JUGIMAPAPI_SRC})
			file(COPY ${JUGIMAPAPI_SRC}/api_c++/jugimap DESTINATION ${JUGIMAPAPI_DEST})
			file(COPY ${JUGIMAPAPI_SRC}/api_c++/jugimapNCINE DESTINATION ${JUGIMAPAPI_DEST})
			file(COPY ${JUGIMAPAPI_SRC}/examples_c++/ParallaxScrolling/engineIndependent DESTINATION ${JUGIMAPAPI_DEST})
			file(COPY ${JUGIMAPAPI_SRC}/examples_c++/ParallaxScrolling/ParallaxScrolling_nCine/ DESTINATION ${JUGIMAPAPI_DEST})
		endif()
	endif()
endfunction()

function(callback_before_target)
	if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android" AND IS_DIRECTORY ${PACKAGE_DATA_DIR})
		set(JUGIMAPAPI_SRC "${CMAKE_BINARY_DIR}/jugimapapi-src")
		if(IS_DIRECTORY ${JUGIMAPAPI_SRC})
			file(COPY ${JUGIMAPAPI_SRC}/examples_c++/ParallaxScrolling/media/fonts DESTINATION ${PACKAGE_DATA_DIR}/data/media)
			file(COPY ${JUGIMAPAPI_SRC}/examples_c++/ParallaxScrolling/media/graphics DESTINATION ${PACKAGE_DATA_DIR}/data/media)
			file(COPY ${JUGIMAPAPI_SRC}/examples_c++/ParallaxScrolling/media/maps DESTINATION ${PACKAGE_DATA_DIR}/data/media)
		endif()

		file(GLOB MEDIA_FONTS RELATIVE ${PACKAGE_DATA_DIR} ${PACKAGE_DATA_DIR}/data/media/fonts/*)
		file(GLOB MEDIA_GRAPHICS RELATIVE ${PACKAGE_DATA_DIR} ${PACKAGE_DATA_DIR}/data/media/graphics/*)
		file(GLOB MEDIA_MAPS RELATIVE ${PACKAGE_DATA_DIR} ${PACKAGE_DATA_DIR}/data/media/maps/*)
		set(PACKAGE_ANDROID_ASSETS ${MEDIA_FONTS} ${MEDIA_GRAPHICS} ${MEDIA_MAPS} CACHE STRING "" FORCE)
	endif()
endfunction()
