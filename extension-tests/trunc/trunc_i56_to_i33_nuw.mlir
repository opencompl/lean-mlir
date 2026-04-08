{
^bb0(%arg0: i56):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i56) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
