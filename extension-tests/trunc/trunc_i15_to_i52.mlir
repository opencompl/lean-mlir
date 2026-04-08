{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) : (i15) -> i52
  "llvm.return"(%0) : (i52) -> ()
}
