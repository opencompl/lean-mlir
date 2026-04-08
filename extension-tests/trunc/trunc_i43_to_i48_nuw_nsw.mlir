{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i43) -> i48
  "llvm.return"(%0) : (i48) -> ()
}
