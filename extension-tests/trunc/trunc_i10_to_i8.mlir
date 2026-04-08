{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) : (i10) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
