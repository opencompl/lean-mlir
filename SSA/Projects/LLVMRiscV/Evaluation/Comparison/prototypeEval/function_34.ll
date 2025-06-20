; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i64 %1) {
  %3 = icmp ult i64 %0, %1
  %4 = zext i1 %3 to i64
  %5 = ashr i64 %4, %0
  %6 = urem i64 %5, %5
  %7 = ashr i64 %6, %4
  ret i64 %7
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
