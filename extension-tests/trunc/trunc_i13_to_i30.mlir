{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) : (i13) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
