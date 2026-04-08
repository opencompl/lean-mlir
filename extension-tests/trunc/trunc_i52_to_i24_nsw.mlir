{
^bb0(%arg0: i52):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i52) -> i24
  "llvm.return"(%0) : (i24) -> ()
}
