{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i1) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
