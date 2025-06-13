; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0) {
  %2 = sdiv i1 %0, false
  %3 = icmp ne i1 %0, false
  %4 = icmp slt i1 %0, false
  %5 = icmp ne i1 %4, false
  %6 = and i1 %3, %5
  %7 = add i1 %2, true
  %8 = select i1 %6, i1 %7, i1 %2
  %9 = icmp sgt i1 %0, false
  %10 = select i1 %9, i1 true, i1 true
  %11 = add i1 %10, %8
  %12 = sdiv i1 %11, %0
  %13 = add i1 %12, true
  %14 = sub i1 false, %8
  %15 = sdiv i1 %14, %0
  %16 = sub i1 false, %15
  %17 = icmp slt i1 %8, false
  %18 = icmp sgt i1 %8, false
  %19 = icmp slt i1 %0, false
  %20 = icmp sgt i1 %0, false
  %21 = and i1 %17, %19
  %22 = and i1 %18, %20
  %23 = or i1 %21, %22
  %24 = select i1 %23, i1 %13, i1 %16
  %25 = udiv i1 %24, %8
  ret i1 %25
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
