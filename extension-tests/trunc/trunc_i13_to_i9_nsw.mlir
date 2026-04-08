{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i13) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
