{
^bb0(%arg0: i63):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i63) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
