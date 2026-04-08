{
^bb0(%arg0: i8):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i8) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
