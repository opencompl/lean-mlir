{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) : (i5) -> i24
  "llvm.return"(%0) : (i24) -> ()
}
