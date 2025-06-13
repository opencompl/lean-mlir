; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i64 %1, i64 %2) {
  %4 = call i64 @llvm.smin.i64(i64 %0, i64 %1)
  %5 = srem i64 %4, %1
  %6 = icmp sgt i64 %2, 0
  %7 = select i1 %6, i64 -1, i64 1
  %8 = add i64 %7, -2293592565771025543
  %9 = sdiv i64 %8, %2
  %10 = add i64 %9, 1
  %11 = sdiv i64 2293592565771025543, %2
  %12 = sub i64 0, %11
  %13 = icmp slt i64 %2, 0
  %14 = icmp sgt i64 %2, 0
  %15 = and i1 true, %13
  %16 = and i1 false, %14
  %17 = or i1 %15, %16
  %18 = select i1 %17, i64 %10, i64 %12
  %19 = sdiv i64 %5, %18
  ret i64 %19
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
