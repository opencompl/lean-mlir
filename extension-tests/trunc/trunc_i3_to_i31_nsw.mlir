{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i3) -> i31
  "llvm.return"(%0) : (i31) -> ()
}
