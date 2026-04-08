{
^bb0(%arg0: i31):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i31) -> i37
  "llvm.return"(%0) : (i37) -> ()
}
