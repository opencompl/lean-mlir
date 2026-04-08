{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i10) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
