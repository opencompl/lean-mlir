{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i14) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
