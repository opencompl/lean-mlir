{
^bb0(%arg0: i62):
  %0 = "llvm.trunc"(%arg0) : (i62) -> i31
  "llvm.return"(%0) : (i31) -> ()
}
