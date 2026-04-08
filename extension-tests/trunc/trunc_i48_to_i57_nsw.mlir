{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i48) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
