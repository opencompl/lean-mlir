{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.icmp"(%arg0, %arg1) <{predicate = 0 : i64}> : (i64, i64) -> i1
%1 = "llvm.sext"(%0) : (i1) -> i64
"llvm.return"(%1) : (i64) -> ()
}
