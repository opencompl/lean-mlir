{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) : (i3) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
