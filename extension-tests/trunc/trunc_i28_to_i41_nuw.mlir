{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i28) -> i41
  "llvm.return"(%0) : (i41) -> ()
}
