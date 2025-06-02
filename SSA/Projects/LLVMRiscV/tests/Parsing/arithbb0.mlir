{
  ^bb0(%arg5: i64, %arg6: i64):
    %3 = "llvm.icmp.ugt"(%arg5, %arg6): (i64, i64) -> i1
    %4 = "llvm.icmp.slt"(%arg5, %arg6) : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
}
