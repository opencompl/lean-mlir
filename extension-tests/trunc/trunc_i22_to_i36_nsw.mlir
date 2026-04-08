{
^bb0(%arg0: i22):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i22) -> i36
  "llvm.return"(%0) : (i36) -> ()
}
