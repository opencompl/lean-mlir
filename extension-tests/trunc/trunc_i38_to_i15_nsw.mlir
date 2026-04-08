{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i38) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
