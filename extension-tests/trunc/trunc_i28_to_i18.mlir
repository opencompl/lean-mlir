{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) : (i28) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
