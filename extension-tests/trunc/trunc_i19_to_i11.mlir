{
^bb0(%arg0: i19):
  %0 = "llvm.trunc"(%arg0) : (i19) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
