{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) : (i44) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
