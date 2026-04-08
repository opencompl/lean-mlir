{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) : (i36) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
