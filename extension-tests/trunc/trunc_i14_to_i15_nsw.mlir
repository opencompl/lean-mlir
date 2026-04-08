{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i14) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
