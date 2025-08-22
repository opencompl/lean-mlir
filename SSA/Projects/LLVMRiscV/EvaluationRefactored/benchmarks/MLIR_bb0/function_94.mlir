{
^bb0(%arg0: i1, %arg1: i64):
%0 = "llvm.zext"(%arg0) : (i1) -> i64
%1 = "llvm.shl"(%0, %arg1) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nsw>} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
