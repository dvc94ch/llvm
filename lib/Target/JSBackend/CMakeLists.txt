add_llvm_target(JSBackendCodeGen
  JSBackend.cpp
  JSTargetMachine.cpp
  JSTargetTransformInfo.cpp
  )

add_dependencies(LLVMJSBackendCodeGen intrinsics_gen)

add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
