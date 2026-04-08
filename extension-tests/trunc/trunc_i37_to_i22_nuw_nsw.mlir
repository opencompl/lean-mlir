{
^bb0(%arg0: i37):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i37) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
