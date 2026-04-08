{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i32) -> i23
  "llvm.return"(%0) : (i23) -> ()
}
