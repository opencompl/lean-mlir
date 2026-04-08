{
^bb0(%arg0: i16):
  %0 = "llvm.trunc"(%arg0) : (i16) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
