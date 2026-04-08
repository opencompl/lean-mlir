{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) : (i64) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
