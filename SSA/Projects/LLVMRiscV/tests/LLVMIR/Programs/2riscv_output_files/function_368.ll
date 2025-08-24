; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i64 %1, i64 %2) {
  %4 = or i64 %1, %2
  %5 = udiv i64 %0, %4
  ret i64 %5
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
