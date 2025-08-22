{
^bb0(%arg0: i64):
%0 = "llvm.shl"(%arg0, %arg0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
%1 = "llvm.shl"(%arg0, %0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nsw>} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
