{
^bb0(%arg0: i42):
  %0 = "llvm.trunc"(%arg0) : (i42) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
