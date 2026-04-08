{
^bb0(%arg0: i24):
  %0 = "llvm.trunc"(%arg0) : (i24) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
