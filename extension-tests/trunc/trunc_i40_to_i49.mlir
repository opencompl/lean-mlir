{
^bb0(%arg0: i40):
  %0 = "llvm.trunc"(%arg0) : (i40) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
