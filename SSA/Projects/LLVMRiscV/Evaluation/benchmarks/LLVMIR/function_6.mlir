; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i64 %1, i64 %2, i1 %3) {
  %5 = ashr i64 %1, %1
  %6 = srem i64 %0, %5
  %7 = ashr i64 %2, %2
  %8 = sub nuw i64 %7, %7
  %9 = lshr i64 %6, %8
  %10 = add nuw i64 %9, %1
  %11 = and i64 %9, %10
  %12 = zext i1 %3 to i64
  %13 = sub nuw i64 %11, %12
  %14 = icmp ult i64 %10, %13
  ret i1 %14
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
