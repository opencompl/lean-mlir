{
^bb0(%arg0: i2):
  %0 = "llvm.trunc"(%arg0) : (i2) -> i19
  "llvm.return"(%0) : (i19) -> ()
}
