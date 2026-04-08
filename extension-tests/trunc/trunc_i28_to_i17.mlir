{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) : (i28) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
