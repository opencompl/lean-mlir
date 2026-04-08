{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i14) -> i10
  "llvm.return"(%0) : (i10) -> ()
}
