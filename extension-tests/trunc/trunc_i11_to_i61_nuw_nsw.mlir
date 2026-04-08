{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i11) -> i61
  "llvm.return"(%0) : (i61) -> ()
}
