{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) : (i45) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
