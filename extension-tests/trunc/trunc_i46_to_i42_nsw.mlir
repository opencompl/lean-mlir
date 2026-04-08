{
^bb0(%arg0: i46):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i46) -> i42
  "llvm.return"(%0) : (i42) -> ()
}
