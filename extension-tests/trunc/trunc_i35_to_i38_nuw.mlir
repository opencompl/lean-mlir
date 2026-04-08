{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i35) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
