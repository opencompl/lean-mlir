{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) : (i3) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
