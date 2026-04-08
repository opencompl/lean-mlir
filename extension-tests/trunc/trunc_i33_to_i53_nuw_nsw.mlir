{
^bb0(%arg0: i33):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i33) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
