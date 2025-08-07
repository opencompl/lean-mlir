; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0) {
  %2 = or i64 %0, %0
  %3 = sub i64 %2, %0
  %4 = srem i64 %3, %3
  %5 = lshr i64 %0, %4
  ret i64 %5
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
