{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) : (i7) -> i55
  "llvm.return"(%0) : (i55) -> ()
}
