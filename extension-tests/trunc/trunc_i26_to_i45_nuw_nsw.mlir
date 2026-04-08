{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i26) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
