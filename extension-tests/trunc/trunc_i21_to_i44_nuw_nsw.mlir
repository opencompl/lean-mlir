{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i21) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
