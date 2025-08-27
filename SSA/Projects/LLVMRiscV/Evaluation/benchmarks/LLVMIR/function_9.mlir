; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i1 %1) {
  %3 = lshr i64 %0, %0
  %4 = sdiv i64 %0, %3
  %5 = mul nuw i64 %0, %4
  %6 = icmp ult i64 %3, %0
  %7 = sext i1 %6 to i64
  %8 = or i64 %5, %7
  %9 = zext i1 %1 to i64
  %10 = and i64 %4, %9
  %11 = sub nuw nsw i64 %0, %10
  %12 = icmp sgt i64 %8, %11
  ret i1 %12
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
