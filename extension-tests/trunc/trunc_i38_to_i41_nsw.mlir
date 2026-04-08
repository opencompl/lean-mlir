{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i38) -> i41
  "llvm.return"(%0) : (i41) -> ()
}
