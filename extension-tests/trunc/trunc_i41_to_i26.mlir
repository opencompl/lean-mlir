{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) : (i41) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
