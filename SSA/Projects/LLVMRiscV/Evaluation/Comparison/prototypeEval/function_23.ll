; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0) {
  %2 = zext i1 %0 to i64
  %3 = select i1 %0, i64 %2, i64 %2
  %4 = trunc nsw i64 %3 to i1
  ret i1 %4
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
