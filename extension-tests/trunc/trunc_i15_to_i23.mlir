{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) : (i15) -> i23
  "llvm.return"(%0) : (i23) -> ()
}
