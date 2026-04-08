{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i11) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
