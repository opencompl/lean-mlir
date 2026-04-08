{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) : (i18) -> i60
  "llvm.return"(%0) : (i60) -> ()
}
