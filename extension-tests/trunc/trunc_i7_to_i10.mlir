{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) : (i7) -> i10
  "llvm.return"(%0) : (i10) -> ()
}
