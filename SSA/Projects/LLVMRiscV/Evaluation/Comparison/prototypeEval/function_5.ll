; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0, i64 %1) {
  %3 = and i64 %0, %0
  %4 = sdiv i64 %3, %1
  %5 = lshr i64 %1, %1
  %6 = ashr i64 %4, %5
  %7 = icmp sge i64 %6, %0
  ret i1 %7
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
