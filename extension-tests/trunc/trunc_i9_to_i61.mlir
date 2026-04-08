{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) : (i9) -> i61
  "llvm.return"(%0) : (i61) -> ()
}
