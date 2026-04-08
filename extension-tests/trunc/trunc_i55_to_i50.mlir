{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) : (i55) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
