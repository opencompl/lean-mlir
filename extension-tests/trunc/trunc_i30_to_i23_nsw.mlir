{
^bb0(%arg0: i30):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i30) -> i23
  "llvm.return"(%0) : (i23) -> ()
}
