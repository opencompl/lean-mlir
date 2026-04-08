{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) : (i55) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
