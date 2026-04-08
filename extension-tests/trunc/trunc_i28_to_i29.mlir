{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) : (i28) -> i29
  "llvm.return"(%0) : (i29) -> ()
}
