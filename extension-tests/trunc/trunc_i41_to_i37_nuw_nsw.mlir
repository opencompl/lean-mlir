{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i41) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
