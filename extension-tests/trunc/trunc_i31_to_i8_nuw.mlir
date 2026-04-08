{
^bb0(%arg0: i31):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i31) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
