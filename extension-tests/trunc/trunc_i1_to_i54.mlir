{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) : (i1) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
