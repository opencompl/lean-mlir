{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i26) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
