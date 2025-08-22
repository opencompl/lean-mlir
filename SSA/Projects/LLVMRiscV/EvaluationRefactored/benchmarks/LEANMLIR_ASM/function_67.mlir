builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.srem"(%0, %1) : (i64, i64) -> (i64)
  "llvm.return"(%2) : (i64) -> ()
 }
