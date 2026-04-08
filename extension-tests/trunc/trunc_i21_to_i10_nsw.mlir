{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i21) -> i10
  "llvm.return"(%0) : (i10) -> ()
}
