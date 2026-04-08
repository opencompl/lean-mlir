{
^bb0(%arg0: i40):
  %0 = "llvm.trunc"(%arg0) : (i40) -> i10
  "llvm.return"(%0) : (i10) -> ()
}
