{
^bb0(%arg0: i2):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i2) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
