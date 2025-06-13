; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i1 %1) {
  %3 = select i1 %1, i64 -382332001542543107, i64 %0
  %4 = call i64 @llvm.smin.i64(i64 %0, i64 %3)
  %5 = udiv i64 -1629065603047637384, %4
  %6 = add i64 %5, 1
  %7 = select i1 false, i64 0, i64 %6
  ret i64 %7
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
