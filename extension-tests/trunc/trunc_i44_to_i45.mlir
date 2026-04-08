{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) : (i44) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
