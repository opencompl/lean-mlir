{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) : (i35) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
