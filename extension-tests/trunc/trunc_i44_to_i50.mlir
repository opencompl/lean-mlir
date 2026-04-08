{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) : (i44) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
