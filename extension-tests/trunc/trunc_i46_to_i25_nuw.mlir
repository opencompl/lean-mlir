{
^bb0(%arg0: i46):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i46) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
