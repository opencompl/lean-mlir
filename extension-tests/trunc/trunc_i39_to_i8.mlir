{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) : (i39) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
