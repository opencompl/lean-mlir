{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) : (i7) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
