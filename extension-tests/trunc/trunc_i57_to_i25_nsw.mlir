{
^bb0(%arg0: i57):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i57) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
