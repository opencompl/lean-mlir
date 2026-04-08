{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) : (i21) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
