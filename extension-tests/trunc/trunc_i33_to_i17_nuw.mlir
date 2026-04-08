{
^bb0(%arg0: i33):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i33) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
