{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i12) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
