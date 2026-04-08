{
^bb0(%arg0: i63):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i63) -> i31
  "llvm.return"(%0) : (i31) -> ()
}
