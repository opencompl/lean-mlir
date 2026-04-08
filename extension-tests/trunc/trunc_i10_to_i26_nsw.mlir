{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i10) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
