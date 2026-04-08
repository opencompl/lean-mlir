{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) : (i36) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
