; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0) {
  %2 = sdiv i1 %0, %0
  %3 = mul i1 %2, %0
  %4 = icmp ne i1 %0, %3
  %5 = icmp slt i1 %0, false
  %6 = icmp slt i1 %0, false
  %7 = icmp ne i1 %5, %6
  %8 = and i1 %4, %7
  %9 = add i1 %2, true
  %10 = select i1 %8, i1 %9, i1 %2
  ret i1 %10
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
