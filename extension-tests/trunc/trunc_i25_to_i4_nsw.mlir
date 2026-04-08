{
^bb0(%arg0: i25):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i25) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
