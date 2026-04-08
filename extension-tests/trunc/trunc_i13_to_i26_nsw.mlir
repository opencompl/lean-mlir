{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i13) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
