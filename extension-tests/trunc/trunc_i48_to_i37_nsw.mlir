{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i48) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
