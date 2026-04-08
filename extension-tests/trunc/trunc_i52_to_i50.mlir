{
^bb0(%arg0: i52):
  %0 = "llvm.trunc"(%arg0) : (i52) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
