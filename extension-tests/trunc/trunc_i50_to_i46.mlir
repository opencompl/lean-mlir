{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) : (i50) -> i46
  "llvm.return"(%0) : (i46) -> ()
}
