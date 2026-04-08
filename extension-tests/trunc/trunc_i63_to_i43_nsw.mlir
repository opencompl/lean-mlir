{
^bb0(%arg0: i63):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i63) -> i43
  "llvm.return"(%0) : (i43) -> ()
}
