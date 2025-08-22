{
^bb0(%arg0: i1, %arg1: i64):
%0 = "llvm.select"(%arg0, %arg1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
%1 = "llvm.lshr"(%0, %arg1) : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
