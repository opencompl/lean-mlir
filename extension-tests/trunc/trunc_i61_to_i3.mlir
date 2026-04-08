{
^bb0(%arg0: i61):
  %0 = "llvm.trunc"(%arg0) : (i61) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
