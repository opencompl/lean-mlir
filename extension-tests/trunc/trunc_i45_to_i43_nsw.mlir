{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i45) -> i43
  "llvm.return"(%0) : (i43) -> ()
}
