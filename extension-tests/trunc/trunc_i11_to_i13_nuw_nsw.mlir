{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i11) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
