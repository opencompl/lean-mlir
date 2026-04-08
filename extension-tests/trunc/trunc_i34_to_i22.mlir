{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) : (i34) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
