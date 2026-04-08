{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) : (i11) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
