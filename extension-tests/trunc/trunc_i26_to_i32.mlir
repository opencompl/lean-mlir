{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) : (i26) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
