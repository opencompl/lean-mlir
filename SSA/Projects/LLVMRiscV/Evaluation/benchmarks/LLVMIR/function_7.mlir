; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i1 %1, i64 %2) {
  %4 = add i64 %0, %0
  %5 = xor i64 %2, %2
  %6 = select i1 %1, i64 %0, i64 %5
  %7 = xor i64 %2, %2
  %8 = lshr i64 %6, %7
  %9 = icmp ult i64 %4, %8
  %10 = sext i1 %9 to i64
  %11 = mul nsw i64 %8, %4
  %12 = shl nsw i64 %10, %11
  %13 = icmp slt i64 %12, %11
  ret i1 %13
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
