{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i55) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
