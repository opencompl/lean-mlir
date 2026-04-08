{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i55) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
