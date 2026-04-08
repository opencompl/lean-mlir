{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i12) -> i60
  "llvm.return"(%0) : (i60) -> ()
}
