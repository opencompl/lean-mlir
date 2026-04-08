{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i32) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
