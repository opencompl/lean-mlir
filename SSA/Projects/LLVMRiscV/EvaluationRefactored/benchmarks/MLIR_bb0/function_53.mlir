{
^bb0(%arg0: i64):
%0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
%1 = "llvm.mul"(%arg0, %0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
