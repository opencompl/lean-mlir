{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) : (i48) -> i6
  "llvm.return"(%0) : (i6) -> ()
}
