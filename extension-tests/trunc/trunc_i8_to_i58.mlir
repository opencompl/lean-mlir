{
^bb0(%arg0: i8):
  %0 = "llvm.trunc"(%arg0) : (i8) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
