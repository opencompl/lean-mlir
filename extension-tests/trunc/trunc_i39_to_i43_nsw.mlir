{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i39) -> i43
  "llvm.return"(%0) : (i43) -> ()
}
