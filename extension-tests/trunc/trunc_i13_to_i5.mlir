{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) : (i13) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
