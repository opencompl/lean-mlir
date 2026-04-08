{
^bb0(%arg0: i8):
  %0 = "llvm.trunc"(%arg0) : (i8) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
