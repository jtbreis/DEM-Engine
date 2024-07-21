# ------------------------------------------------------------------------------
# Additional include paths and libraries
# ------------------------------------------------------------------------------

# INCLUDE_DIRECTORIES(${ProjectIncludeRoot})

SET(LIBRARIES
		simulator_multi_gpu
)

# ------------------------------------------------------------------------------
# List of all executables
# ------------------------------------------------------------------------------

SET(DEMOS
		DEMdemo_SingleSphereCollide
)

# ------------------------------------------------------------------------------
# Add all executables
# ------------------------------------------------------------------------------

message(STATUS "Demo programs for DEM solver...")

FOREACH(PROGRAM ${DEMOS})
		
		message(STATUS "...add ${PROGRAM}")

		add_executable(${PROGRAM}  "${PROGRAM}.cpp")

		set_target_properties(
			${PROGRAM} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${DEME_INSTALL_DEMO}"
		)

		if(WIN32)
			# set_property(TARGET ${PROGRAM} 
			# 	PROPERTY VS_DEBUGGER_ENVIRONMENT "PATH=$<TARGET_FILE_DIR:DEMERuntimeDataHelper_install>;%PATH%"
			# )
			# set_property(TARGET ${PROGRAM} 
			# 	PROPERTY VS_DEBUGGER_ENVIRONMENT "PATH=$<TARGET_FILE_DIR:DEMERuntimeDataHelper>;%PATH%"
			# )
			add_custom_command(TARGET ${PROGRAM} POST_BUILD
                       COMMAND ${CMAKE_COMMAND} -E copy_if_different
                       "$<TARGET_FILE_DIR:DEMERuntimeDataHelper_install>/DEMERuntimeDataHelper_install.dll"
					   "$<TARGET_FILE_DIR:DEMERuntimeDataHelper_install>/DEMERuntimeDataHelper.dll"
                       "$<TARGET_FILE_DIR:${PROGRAM}>")
		endif()
		
		source_group("" FILES "${PROGRAM}.cpp")
		
		target_link_libraries(${PROGRAM} 
			PUBLIC ${LIBRARIES}
			PUBLIC ${EXTERNAL_LIBRARIES}
		)
		
		add_dependencies(${PROGRAM} ${LIBRARIES})

		set_target_properties(
			${PROGRAM} PROPERTIES
			CXX_STANDARD ${CXXSTD_SUPPORTED}
		)

		# install(TARGETS ${PROGRAM} DESTINATION ${DEME_INSTALL_DEMO})

ENDFOREACH(PROGRAM)

