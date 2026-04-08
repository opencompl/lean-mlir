{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i44) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
