{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i41) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
