{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) : (i28) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
