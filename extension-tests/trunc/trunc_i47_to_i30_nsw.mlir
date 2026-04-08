{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i47) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
