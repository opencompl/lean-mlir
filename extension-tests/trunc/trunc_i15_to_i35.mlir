{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) : (i15) -> i35
  "llvm.return"(%0) : (i35) -> ()
}
