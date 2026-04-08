{
^bb0(%arg0: i54):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i54) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
