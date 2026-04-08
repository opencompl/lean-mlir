{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) : (i1) -> i60
  "llvm.return"(%0) : (i60) -> ()
}
