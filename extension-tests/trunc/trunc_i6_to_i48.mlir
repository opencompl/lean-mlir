{
^bb0(%arg0: i6):
  %0 = "llvm.trunc"(%arg0) : (i6) -> i48
  "llvm.return"(%0) : (i48) -> ()
}
