; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i64 %1, i64 %2) {
  %4 = or i64 %1, %2
  %5 = urem i64 %0, %4
  %6 = or i64 %5, %4
  %7 = icmp slt i64 %6, %0
  %8 = sext i1 %7 to i64
  %9 = icmp ne i64 %6, %8
  ret i1 %9
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
