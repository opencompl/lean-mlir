{
^bb0(%arg0: i20):
  %0 = "llvm.trunc"(%arg0) : (i20) -> i24
  "llvm.return"(%0) : (i24) -> ()
}
