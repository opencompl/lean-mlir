{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i64) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
