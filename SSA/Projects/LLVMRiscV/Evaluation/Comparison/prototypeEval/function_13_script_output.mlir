{
  ^bb0(%arg0: i64, %arg1: i1):
    %0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.sext"(%arg1) : (i1) -> i64
    %2 = "llvm.sdiv"(%0, %1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}
