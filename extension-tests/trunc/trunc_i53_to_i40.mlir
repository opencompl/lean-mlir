{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) : (i53) -> i40
  "llvm.return"(%0) : (i40) -> ()
}
