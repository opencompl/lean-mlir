{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i60) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
