{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i3) -> i24
  "llvm.return"(%0) : (i24) -> ()
}
