{
^bb0(%arg0: i56):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i56) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
