{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i60) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
