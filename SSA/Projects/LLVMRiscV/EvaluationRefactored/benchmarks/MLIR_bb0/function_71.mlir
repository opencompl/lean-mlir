{
^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
%0 = "llvm.select"(%arg0, %arg1, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
%1 = "llvm.mul"(%0, %arg2) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
