{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i38) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
