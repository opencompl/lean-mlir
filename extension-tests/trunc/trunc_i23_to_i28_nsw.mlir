{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i23) -> i28
  "llvm.return"(%0) : (i28) -> ()
}
