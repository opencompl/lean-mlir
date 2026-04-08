{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) : (i13) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
