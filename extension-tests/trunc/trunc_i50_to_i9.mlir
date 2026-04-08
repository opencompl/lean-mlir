{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) : (i50) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
