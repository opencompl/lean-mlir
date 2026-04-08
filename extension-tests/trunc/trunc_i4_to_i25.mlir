{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) : (i4) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
