{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i14) -> i39
  "llvm.return"(%0) : (i39) -> ()
}
