{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i43) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
