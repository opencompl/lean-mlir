{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) : (i43) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
