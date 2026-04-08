{
^bb0(%arg0: i27):
  %0 = "llvm.trunc"(%arg0) : (i27) -> i20
  "llvm.return"(%0) : (i20) -> ()
}
