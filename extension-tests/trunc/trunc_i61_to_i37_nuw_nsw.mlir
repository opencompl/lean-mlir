{
^bb0(%arg0: i61):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i61) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
