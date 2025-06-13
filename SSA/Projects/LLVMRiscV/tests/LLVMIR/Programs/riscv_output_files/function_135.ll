; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i1 %1) {
  %3 = sdiv i1 %0, %0
  %4 = icmp eq i1 %3, false
  %5 = sub i1 %3, true
  %6 = udiv i1 %5, %1
  %7 = add i1 %6, true
  %8 = select i1 %4, i1 false, i1 %7
  %9 = sub i1 true, %1
  %10 = udiv i1 true, %9
  %11 = add i1 %10, true
  %12 = select i1 true, i1 false, i1 %11
  %13 = add nsw i1 %8, %12
  ret i1 %13
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
