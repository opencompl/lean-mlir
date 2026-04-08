{
^bb0(%arg0: i63):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i63) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
