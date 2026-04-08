{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i28) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
