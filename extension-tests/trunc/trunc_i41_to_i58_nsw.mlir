{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i41) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
