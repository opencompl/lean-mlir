builtin.module { 
^bb0(%0 : i64):
  %1 = "llvm.icmp"(%0, %0)ugt : (i64, i64) -> (i1)
  "llvm.return"(%1) : (i1) -> ()
 }
