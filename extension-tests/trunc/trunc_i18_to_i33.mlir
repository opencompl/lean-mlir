{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) : (i18) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
