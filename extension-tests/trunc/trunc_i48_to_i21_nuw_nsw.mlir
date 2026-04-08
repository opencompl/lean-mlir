{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i48) -> i21
  "llvm.return"(%0) : (i21) -> ()
}
