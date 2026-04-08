{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i3) -> i46
  "llvm.return"(%0) : (i46) -> ()
}
