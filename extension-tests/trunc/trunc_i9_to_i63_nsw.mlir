{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i9) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
