{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) : (i55) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
