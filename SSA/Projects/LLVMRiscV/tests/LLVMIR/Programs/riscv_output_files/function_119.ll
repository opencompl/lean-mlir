; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0) {
  %2 = srem i1 true, %0
  %3 = icmp eq i1 %0, false
  %4 = sub i1 %0, true
  %5 = udiv i1 %4, %2
  %6 = add i1 %5, true
  %7 = select i1 %3, i1 false, i1 %6
  ret i1 %7
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
