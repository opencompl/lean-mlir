{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) : (i23) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
