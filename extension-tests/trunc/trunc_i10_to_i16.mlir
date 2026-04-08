{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) : (i10) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
