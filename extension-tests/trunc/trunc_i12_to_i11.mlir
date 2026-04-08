{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) : (i12) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
