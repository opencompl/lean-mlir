{
^bb0(%arg0: i27):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i27) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
