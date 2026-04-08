{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i41) -> i28
  "llvm.return"(%0) : (i28) -> ()
}
