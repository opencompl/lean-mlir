; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i64 %1) {
  %3 = sdiv i64 %1, %0
  %4 = icmp sle i64 %1, %3
  %5 = zext i1 %4 to i64
  %6 = icmp ne i64 %0, %5
  ret i1 %6
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
