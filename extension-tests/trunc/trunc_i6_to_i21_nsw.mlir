{
^bb0(%arg0: i6):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i6) -> i21
  "llvm.return"(%0) : (i21) -> ()
}
