; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i64 %1) {
  %3 = xor i64 %1, %0
  %4 = sdiv i64 %0, %3
  ret i64 %4
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
