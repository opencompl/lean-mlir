{
^bb0(%arg0: i24):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i24) -> i19
  "llvm.return"(%0) : (i19) -> ()
}
