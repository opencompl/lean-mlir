{
^bb0(%arg0: i46):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i46) -> i21
  "llvm.return"(%0) : (i21) -> ()
}
