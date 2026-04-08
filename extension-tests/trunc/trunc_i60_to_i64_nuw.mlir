{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i60) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
