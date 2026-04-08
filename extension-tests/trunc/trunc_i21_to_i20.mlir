{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) : (i21) -> i20
  "llvm.return"(%0) : (i20) -> ()
}
