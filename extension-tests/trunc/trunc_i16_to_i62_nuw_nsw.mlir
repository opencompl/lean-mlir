{
^bb0(%arg0: i16):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i16) -> i62
  "llvm.return"(%0) : (i62) -> ()
}
