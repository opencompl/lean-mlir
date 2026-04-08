{
^bb0(%arg0: i29):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i29) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
