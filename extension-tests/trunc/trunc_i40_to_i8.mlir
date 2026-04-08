{
^bb0(%arg0: i40):
  %0 = "llvm.trunc"(%arg0) : (i40) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
