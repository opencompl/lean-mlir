{
^bb0(%arg0: i27):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i27) -> i39
  "llvm.return"(%0) : (i39) -> ()
}
