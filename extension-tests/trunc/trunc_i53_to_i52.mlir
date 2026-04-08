{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) : (i53) -> i52
  "llvm.return"(%0) : (i52) -> ()
}
