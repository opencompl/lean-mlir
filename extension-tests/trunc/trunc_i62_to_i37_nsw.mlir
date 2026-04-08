{
^bb0(%arg0: i62):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i62) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
