; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i64 %1, i64 %2) {
  %4 = xor i64 %0, %1
  %5 = lshr i64 %4, %1
  %6 = shl nuw i64 %4, %1
  %7 = srem i64 %5, %6
  %8 = xor i64 %0, %0
  %9 = udiv i64 %5, %1
  %10 = lshr i64 %9, %6
  %11 = mul nuw i64 %10, %2
  %12 = sdiv i64 %8, %11
  %13 = icmp ule i64 %7, %12
  ret i1 %13
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
