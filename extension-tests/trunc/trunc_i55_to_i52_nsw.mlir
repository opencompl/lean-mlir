{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i55) -> i52
  "llvm.return"(%0) : (i52) -> ()
}
