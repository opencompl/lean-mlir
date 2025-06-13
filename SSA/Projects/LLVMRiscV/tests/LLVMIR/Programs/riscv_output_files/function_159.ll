; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i1 %1, i64 %2) {
  %4 = sdiv i1 %0, %1
  %5 = call i1 @llvm.smax.i1(i1 %0, i1 %4)
  %6 = zext i1 %5 to i64
  %7 = icmp ule i64 %6, %2
  ret i1 %7
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.smax.i1(i1, i1) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
