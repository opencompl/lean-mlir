{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i11) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
