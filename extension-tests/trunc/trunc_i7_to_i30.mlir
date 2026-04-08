{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) : (i7) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
