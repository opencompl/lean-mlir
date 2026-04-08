{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i4) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
