{
^bb0(%arg0: i22):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i22) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
