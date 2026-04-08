{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) : (i28) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
