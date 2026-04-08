{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) : (i12) -> i40
  "llvm.return"(%0) : (i40) -> ()
}
