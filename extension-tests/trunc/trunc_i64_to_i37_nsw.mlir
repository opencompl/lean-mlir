{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i64) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
