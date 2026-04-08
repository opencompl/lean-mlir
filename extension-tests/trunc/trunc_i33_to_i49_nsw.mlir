{
^bb0(%arg0: i33):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i33) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
