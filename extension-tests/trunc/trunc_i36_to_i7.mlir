{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) : (i36) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
