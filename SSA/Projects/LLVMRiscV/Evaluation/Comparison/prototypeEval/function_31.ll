; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i1 %1, i64 %2) {
  %4 = select i1 %1, i64 %2, i64 %0
  %5 = mul i64 %4, %4
  %6 = icmp eq i64 %0, %5
  ret i1 %6
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
