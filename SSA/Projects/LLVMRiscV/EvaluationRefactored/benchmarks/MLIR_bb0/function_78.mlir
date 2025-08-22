{
^bb0(%arg0: i64):
%0 = "llvm.sub"(%arg0, %arg0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nsw, nuw>} : (i64, i64) -> i64
%1 = "llvm.or"(%arg0, %0) : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
