; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i1 %1) {
  %3 = zext i1 %1 to i64
  %4 = sdiv i64 %0, %3
  %5 = mul i64 %4, %3
  %6 = icmp ne i64 %0, %5
  %7 = icmp slt i64 %0, 0
  %8 = icmp slt i64 %3, 0
  %9 = icmp ne i1 %7, %8
  %10 = and i1 %6, %9
  %11 = add i64 %4, -1
  %12 = select i1 %10, i64 %11, i64 %4
  ret i64 %12
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
