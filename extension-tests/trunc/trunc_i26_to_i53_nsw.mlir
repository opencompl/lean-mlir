{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i26) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
