{
^bb0(%arg0: i46):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i46) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
