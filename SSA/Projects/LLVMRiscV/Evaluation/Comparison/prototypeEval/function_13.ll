; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i1 %1) {
  %3 = lshr i64 %0, %0
  %4 = sext i1 %1 to i64
  %5 = sdiv i64 %3, %4
  ret i64 %5
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
