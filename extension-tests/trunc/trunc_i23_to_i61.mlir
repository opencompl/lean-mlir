{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) : (i23) -> i61
  "llvm.return"(%0) : (i61) -> ()
}
