{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) : (i60) -> i6
  "llvm.return"(%0) : (i6) -> ()
}
