{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) : (i55) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
