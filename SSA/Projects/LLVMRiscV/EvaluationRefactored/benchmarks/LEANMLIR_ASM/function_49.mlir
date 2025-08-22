builtin.module { 
^bb0(%0 : i64):
  %1 = "llvm.srem"(%0, %0) : (i64, i64) -> (i64)
  "llvm.return"(%1) : (i64) -> ()
 }
