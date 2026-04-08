{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) : (i18) -> i40
  "llvm.return"(%0) : (i40) -> ()
}
