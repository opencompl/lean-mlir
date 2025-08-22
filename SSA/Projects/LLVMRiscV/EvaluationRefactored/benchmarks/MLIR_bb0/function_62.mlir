{
^bb0(%arg0: i1):
%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<none>} : (i1) -> i64
"llvm.return"(%0) : (i64) -> ()
}
