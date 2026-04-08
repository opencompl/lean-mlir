{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i38) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
