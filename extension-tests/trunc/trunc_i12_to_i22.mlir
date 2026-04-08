{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) : (i12) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
