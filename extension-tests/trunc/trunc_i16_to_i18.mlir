{
^bb0(%arg0: i16):
  %0 = "llvm.trunc"(%arg0) : (i16) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
