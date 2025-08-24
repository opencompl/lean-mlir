; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i64 %0) {
  %2 = icmp ult i64 %0, %0
  %3 = sext i1 %2 to i64
  %4 = icmp sgt i64 %3, %0
  ret i1 %4
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
