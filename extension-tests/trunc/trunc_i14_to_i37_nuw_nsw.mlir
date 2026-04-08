{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i14) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
