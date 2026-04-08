{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) : (i34) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
