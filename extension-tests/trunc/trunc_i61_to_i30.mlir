{
^bb0(%arg0: i61):
  %0 = "llvm.trunc"(%arg0) : (i61) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
