{
^bb0(%arg0: i31):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i31) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
