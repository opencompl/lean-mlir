{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) : (i60) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
