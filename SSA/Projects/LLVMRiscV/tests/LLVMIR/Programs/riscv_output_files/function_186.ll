; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i1 %1, i1 %2) {
  %4 = sdiv i1 %1, %2
  %5 = mul i1 %4, %2
  %6 = icmp ne i1 %1, %5
  %7 = icmp slt i1 %1, false
  %8 = icmp slt i1 %2, false
  %9 = icmp ne i1 %7, %8
  %10 = and i1 %6, %9
  %11 = add i1 %4, true
  %12 = select i1 %10, i1 %11, i1 %4
  %13 = sdiv i1 %0, %12
  %14 = xor i1 %2, true
  %15 = sdiv i1 %13, %14
  %16 = mul i1 %15, %14
  %17 = icmp ne i1 %13, %16
  %18 = icmp slt i1 %13, false
  %19 = icmp slt i1 %14, false
  %20 = icmp ne i1 %18, %19
  %21 = and i1 %17, %20
  %22 = add i1 %15, true
  %23 = select i1 %21, i1 %22, i1 %15
  ret i1 %23
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
