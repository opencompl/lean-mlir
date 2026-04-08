{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) : (i53) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
