; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main() {
  ret i1 true
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
