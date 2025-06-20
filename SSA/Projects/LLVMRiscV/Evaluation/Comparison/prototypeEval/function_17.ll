; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0, i64 %1, i1 %2) {
  %4 = xor i64 %0, %1
  %5 = zext i1 %2 to i64
  %6 = shl nuw i64 %5, %4
  %7 = xor i64 %6, %6
  %8 = mul nuw i64 %4, %7
  ret i64 %8
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
