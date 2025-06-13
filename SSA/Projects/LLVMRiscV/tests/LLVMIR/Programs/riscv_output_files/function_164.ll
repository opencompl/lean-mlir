; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i1 %1) {
  %3 = icmp sle i1 %0, false
  %4 = icmp eq i1 %0, false
  %5 = sub i1 %0, true
  %6 = udiv i1 %5, false
  %7 = add i1 %6, true
  %8 = select i1 %4, i1 false, i1 %7
  %9 = sdiv i1 %8, false
  %10 = call i1 @llvm.smax.i1(i1 %1, i1 %9)
  %11 = and i1 %3, %10
  ret i1 %11
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.smax.i1(i1, i1) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
