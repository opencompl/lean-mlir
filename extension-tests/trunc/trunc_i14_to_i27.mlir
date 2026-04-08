{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) : (i14) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
