; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0) {
  %2 = sdiv i64 3220996587549851491, %0
  %3 = mul i64 %2, %0
  %4 = icmp ne i64 %3, 3220996587549851491
  %5 = icmp slt i64 %0, 0
  %6 = icmp ne i1 false, %5
  %7 = and i1 %4, %6
  %8 = add i64 %2, -1
  %9 = select i1 %7, i64 %8, i64 %2
  %10 = lshr i64 %9, %9
  %11 = icmp sgt i64 %0, 0
  %12 = select i1 %11, i64 -1, i64 1
  %13 = add i64 %12, %10
  %14 = sdiv i64 %13, %0
  %15 = add i64 %14, 1
  %16 = sub i64 0, %10
  %17 = sdiv i64 %16, %0
  %18 = sub i64 0, %17
  %19 = icmp slt i64 %10, 0
  %20 = icmp sgt i64 %10, 0
  %21 = icmp slt i64 %0, 0
  %22 = icmp sgt i64 %0, 0
  %23 = and i1 %19, %21
  %24 = and i1 %20, %22
  %25 = or i1 %23, %24
  %26 = select i1 %25, i64 %15, i64 %18
  %27 = call i64 @llvm.umin.i64(i64 %26, i64 %10)
  %28 = or i64 %27, %9
  ret i64 %28
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
