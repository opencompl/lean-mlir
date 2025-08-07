; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i1 %0, i64 %1, i64 %2) {
  %4 = zext i1 %0 to i64
  %5 = sdiv i64 %4, %4
  %6 = srem i64 %4, %5
  %7 = sub nuw nsw i64 %5, %6
  %8 = ashr i64 %5, %7
  %9 = sdiv i64 %8, %6
  %10 = select i1 %0, i64 %5, i64 %9
  %11 = add nsw i64 %1, %10
  %12 = add nsw i64 %11, %2
  %13 = xor i64 %10, %12
  ret i64 %13
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
