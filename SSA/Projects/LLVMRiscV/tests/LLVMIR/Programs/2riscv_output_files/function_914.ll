; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0) {
  %2 = xor i64 %0, %0
  %3 = icmp eq i64 %0, %2
  ret i1 %3
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
