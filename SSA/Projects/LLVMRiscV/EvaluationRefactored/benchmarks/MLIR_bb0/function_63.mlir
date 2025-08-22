{
^bb0(%arg0: i64):
%0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 2 : i64}> : (i64, i64) -> i1
"llvm.return"(%0) : (i1) -> ()
}
