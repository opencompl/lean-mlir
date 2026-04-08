{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i7) -> i56
  "llvm.return"(%0) : (i56) -> ()
}
