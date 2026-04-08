{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) : (i13) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
