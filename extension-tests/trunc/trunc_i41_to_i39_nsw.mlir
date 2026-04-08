{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i41) -> i39
  "llvm.return"(%0) : (i39) -> ()
}
