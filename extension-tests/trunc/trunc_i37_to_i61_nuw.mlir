{
^bb0(%arg0: i37):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i37) -> i61
  "llvm.return"(%0) : (i61) -> ()
}
