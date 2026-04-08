{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) : (i51) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
