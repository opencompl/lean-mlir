{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) : (i44) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
