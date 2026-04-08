{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) : (i44) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
