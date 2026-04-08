{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) : (i64) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
