{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) : (i1) -> i62
  "llvm.return"(%0) : (i62) -> ()
}
