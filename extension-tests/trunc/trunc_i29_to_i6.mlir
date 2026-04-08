{
^bb0(%arg0: i29):
  %0 = "llvm.trunc"(%arg0) : (i29) -> i6
  "llvm.return"(%0) : (i6) -> ()
}
