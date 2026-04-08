{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) : (i4) -> i36
  "llvm.return"(%0) : (i36) -> ()
}
