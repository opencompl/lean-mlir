{
^bb0(%arg0: i59):
  %0 = "llvm.trunc"(%arg0) : (i59) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
