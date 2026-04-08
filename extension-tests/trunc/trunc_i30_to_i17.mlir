{
^bb0(%arg0: i30):
  %0 = "llvm.trunc"(%arg0) : (i30) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
