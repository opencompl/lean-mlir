{
^bb0(%arg0: i54):
  %0 = "llvm.trunc"(%arg0) : (i54) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
