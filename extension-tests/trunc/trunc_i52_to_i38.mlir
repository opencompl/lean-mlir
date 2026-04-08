{
^bb0(%arg0: i52):
  %0 = "llvm.trunc"(%arg0) : (i52) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
