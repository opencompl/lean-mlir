; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i1 %1) {
  %3 = select i1 %0, i1 %0, i1 %1
  %4 = icmp ugt i1 %0, %3
  ret i1 %4
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
