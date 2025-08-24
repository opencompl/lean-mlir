; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i1 %0, i64 %1) {
  %3 = select i1 %0, i64 %1, i64 %1
  ret i64 %3
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
