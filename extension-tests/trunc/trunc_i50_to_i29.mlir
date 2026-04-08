{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) : (i50) -> i29
  "llvm.return"(%0) : (i29) -> ()
}
