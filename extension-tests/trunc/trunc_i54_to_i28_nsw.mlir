{
^bb0(%arg0: i54):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i54) -> i28
  "llvm.return"(%0) : (i28) -> ()
}
