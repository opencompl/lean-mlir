; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0) {
  %2 = sext i1 %0 to i64
  %3 = udiv i64 %2, %2
  %4 = and i64 %2, %3
  %5 = trunc i64 %4 to i1
  ret i1 %5
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
