{
^bb0(%arg0: i63):
  %0 = "llvm.trunc"(%arg0) : (i63) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
