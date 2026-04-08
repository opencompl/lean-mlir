{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) : (i28) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
