{
^bb0(%arg0: i37):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i37) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
