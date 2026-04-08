{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i51) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
