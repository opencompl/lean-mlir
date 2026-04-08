{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) : (i47) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
