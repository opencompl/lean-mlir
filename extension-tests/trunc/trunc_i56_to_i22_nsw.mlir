{
^bb0(%arg0: i56):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i56) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
