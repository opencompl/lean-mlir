{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) : (i12) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
