{
^bb0(%arg0: i2):
  %0 = "llvm.trunc"(%arg0) : (i2) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
