{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i13) -> i23
  "llvm.return"(%0) : (i23) -> ()
}
