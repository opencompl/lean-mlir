{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i11) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
