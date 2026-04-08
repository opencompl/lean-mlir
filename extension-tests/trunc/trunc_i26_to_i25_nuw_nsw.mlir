{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i26) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
