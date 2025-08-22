{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.shl"(%arg0, %arg1) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
%1 = "llvm.icmp"(%0, %arg0) <{predicate = 7 : i64}> : (i64, i64) -> i1
"llvm.return"(%1) : (i1) -> ()
}
