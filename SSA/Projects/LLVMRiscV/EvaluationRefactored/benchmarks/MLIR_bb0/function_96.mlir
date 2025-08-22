{
^bb0(%arg0: i1):
%0 = "llvm.zext"(%arg0) : (i1) -> i64
%1 = "llvm.add"(%0, %0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nsw>} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
