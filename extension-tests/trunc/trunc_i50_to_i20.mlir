{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) : (i50) -> i20
  "llvm.return"(%0) : (i20) -> ()
}
