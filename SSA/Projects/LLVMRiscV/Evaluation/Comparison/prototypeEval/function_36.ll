; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i1 %1) {
  %3 = sext i1 %1 to i64
  %4 = mul nuw i64 %0, %3
  %5 = xor i64 %0, %4
  %6 = or i64 %0, %5
  ret i64 %6
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
