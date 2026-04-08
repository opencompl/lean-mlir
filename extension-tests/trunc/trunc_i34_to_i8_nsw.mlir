{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i34) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
