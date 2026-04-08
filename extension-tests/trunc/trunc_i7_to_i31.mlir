{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) : (i7) -> i31
  "llvm.return"(%0) : (i31) -> ()
}
