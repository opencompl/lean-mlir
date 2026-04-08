{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) : (i12) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
