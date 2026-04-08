{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i60) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
