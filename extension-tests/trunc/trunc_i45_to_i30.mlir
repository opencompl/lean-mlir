{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) : (i45) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
