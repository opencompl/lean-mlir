{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i32) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
