{
^bb0(%arg0: i31):
  %0 = "llvm.trunc"(%arg0) : (i31) -> i61
  "llvm.return"(%0) : (i61) -> ()
}
