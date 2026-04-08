{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i50) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
