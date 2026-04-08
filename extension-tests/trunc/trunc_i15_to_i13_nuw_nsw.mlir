{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i15) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
