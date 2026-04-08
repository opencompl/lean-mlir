{
^bb0(%arg0: i40):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i40) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
