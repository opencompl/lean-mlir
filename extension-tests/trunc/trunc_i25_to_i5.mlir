{
^bb0(%arg0: i25):
  %0 = "llvm.trunc"(%arg0) : (i25) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
