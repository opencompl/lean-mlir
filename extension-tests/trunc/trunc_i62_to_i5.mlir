{
^bb0(%arg0: i62):
  %0 = "llvm.trunc"(%arg0) : (i62) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
