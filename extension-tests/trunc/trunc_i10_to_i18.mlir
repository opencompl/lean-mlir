{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) : (i10) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
