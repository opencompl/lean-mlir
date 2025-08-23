; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i64 %1) {
  %3 = select i1 %0, i64 %1, i64 %1
  %4 = ashr i64 %3, %1
  %5 = trunc nsw i64 %4 to i1
  ret i1 %5
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
