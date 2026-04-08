{
^bb0(%arg0: i63):
  %0 = "llvm.trunc"(%arg0) : (i63) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
