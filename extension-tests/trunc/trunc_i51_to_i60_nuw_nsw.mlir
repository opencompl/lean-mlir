{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i51) -> i60
  "llvm.return"(%0) : (i60) -> ()
}
