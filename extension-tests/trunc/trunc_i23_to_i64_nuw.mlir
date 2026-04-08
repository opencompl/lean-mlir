{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i23) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
