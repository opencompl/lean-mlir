{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i32) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
