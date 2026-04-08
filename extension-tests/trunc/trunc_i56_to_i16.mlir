{
^bb0(%arg0: i56):
  %0 = "llvm.trunc"(%arg0) : (i56) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
