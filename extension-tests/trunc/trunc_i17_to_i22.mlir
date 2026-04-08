{
^bb0(%arg0: i17):
  %0 = "llvm.trunc"(%arg0) : (i17) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
