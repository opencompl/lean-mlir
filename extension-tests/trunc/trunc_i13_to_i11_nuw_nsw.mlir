{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i13) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
