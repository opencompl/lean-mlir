{
^bb0(%arg0: i49):
  %0 = "llvm.trunc"(%arg0) : (i49) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
