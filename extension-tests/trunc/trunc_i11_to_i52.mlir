{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) : (i11) -> i52
  "llvm.return"(%0) : (i52) -> ()
}
