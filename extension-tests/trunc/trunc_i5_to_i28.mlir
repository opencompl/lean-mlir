{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) : (i5) -> i28
  "llvm.return"(%0) : (i28) -> ()
}
