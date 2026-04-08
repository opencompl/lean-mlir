{
^bb0(%arg0: i59):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i59) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
