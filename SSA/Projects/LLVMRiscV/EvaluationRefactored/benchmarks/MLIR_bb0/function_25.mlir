{
^bb0(%arg0: i1):
%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nsw, nuw>} : (i1) -> i64
%1 = "llvm.and"(%0, %0) : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
