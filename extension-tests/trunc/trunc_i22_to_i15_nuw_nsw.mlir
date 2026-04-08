{
^bb0(%arg0: i22):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i22) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
