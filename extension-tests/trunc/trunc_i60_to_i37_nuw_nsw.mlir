{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i60) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
