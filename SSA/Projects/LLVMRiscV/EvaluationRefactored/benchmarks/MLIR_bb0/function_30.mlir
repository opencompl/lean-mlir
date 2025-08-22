{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 9 : i64}> : (i64, i64) -> i1
%1 = "llvm.select"(%0, %arg1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
