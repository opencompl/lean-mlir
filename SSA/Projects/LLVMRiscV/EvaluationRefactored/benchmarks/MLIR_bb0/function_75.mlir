{
^bb0(%arg0: i64):
%0 = "llvm.sub"(%arg0, %arg0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nsw>} : (i64, i64) -> i64
"llvm.return"(%0) : (i64) -> ()
}
