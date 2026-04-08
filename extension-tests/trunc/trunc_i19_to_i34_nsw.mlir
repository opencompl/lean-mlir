{
^bb0(%arg0: i19):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i19) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
