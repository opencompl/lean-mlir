{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i5) -> i21
  "llvm.return"(%0) : (i21) -> ()
}
