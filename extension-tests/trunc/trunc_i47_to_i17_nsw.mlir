{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i47) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
