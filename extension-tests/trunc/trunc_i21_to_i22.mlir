{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) : (i21) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
