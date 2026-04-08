{
^bb0(%arg0: i17):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i17) -> i41
  "llvm.return"(%0) : (i41) -> ()
}
