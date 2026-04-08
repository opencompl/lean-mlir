{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) : (i34) -> i42
  "llvm.return"(%0) : (i42) -> ()
}
