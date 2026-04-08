{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) : (i26) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
