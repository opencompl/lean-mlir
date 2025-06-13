; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0) {
  %2 = urem i64 %0, %0
  %3 = icmp sgt i64 %2, 0
  %4 = select i1 %3, i64 -1, i64 1
  %5 = add i64 %4, %0
  %6 = sdiv i64 %5, %2
  %7 = add i64 %6, 1
  %8 = sub i64 0, %0
  %9 = sdiv i64 %8, %2
  %10 = sub i64 0, %9
  %11 = icmp slt i64 %0, 0
  %12 = icmp sgt i64 %0, 0
  %13 = icmp slt i64 %2, 0
  %14 = icmp sgt i64 %2, 0
  %15 = and i1 %11, %13
  %16 = and i1 %12, %14
  %17 = or i1 %15, %16
  %18 = select i1 %17, i64 %7, i64 %10
  %19 = xor i64 %18, -1134788058768042145
  ret i64 %19
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
