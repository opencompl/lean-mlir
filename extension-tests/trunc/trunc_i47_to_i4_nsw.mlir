{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i47) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
