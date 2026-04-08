{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) : (i43) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
