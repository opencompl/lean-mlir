; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i1 @main(i1 %0, i1 %1, i1 %2) {
  %4 = and i1 false, %0
  %5 = urem i1 %2, false
  %6 = lshr i1 %1, %5
  %7 = ashr i1 %4, %6
  ret i1 %7
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
