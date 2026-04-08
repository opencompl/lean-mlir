{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) : (i38) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
