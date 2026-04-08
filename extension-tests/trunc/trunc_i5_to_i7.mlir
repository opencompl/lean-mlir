{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) : (i5) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
