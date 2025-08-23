; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i1 %1, i64 %2) {
  %4 = select i1 %1, i64 %2, i64 %0
  %5 = mul i64 %0, %4
  %6 = ashr i64 %0, %5
  %7 = icmp slt i64 %6, %6
  %8 = sext i1 %7 to i64
  ret i64 %8
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
