; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0) {
  %2 = icmp sgt i64 %0, %0
  %3 = zext i1 %2 to i64
  ret i64 %3
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
