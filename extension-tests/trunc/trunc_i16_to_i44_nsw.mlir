{
^bb0(%arg0: i16):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i16) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
