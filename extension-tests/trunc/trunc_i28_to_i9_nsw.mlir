{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i28) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
