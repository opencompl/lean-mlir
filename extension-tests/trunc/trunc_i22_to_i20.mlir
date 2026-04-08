{
^bb0(%arg0: i22):
  %0 = "llvm.trunc"(%arg0) : (i22) -> i20
  "llvm.return"(%0) : (i20) -> ()
}
