{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i34) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
