{
^bb0(%arg0: i22):
  %0 = "llvm.trunc"(%arg0) : (i22) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
