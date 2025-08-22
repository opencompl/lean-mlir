{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.mul"(%arg0, %arg1) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
"llvm.return"(%0) : (i64) -> ()
}
