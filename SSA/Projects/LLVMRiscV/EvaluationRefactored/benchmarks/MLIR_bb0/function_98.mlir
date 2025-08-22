{
^bb0(%arg0: i1):
%0 = "llvm.zext"(%arg0) : (i1) -> i64
%1 = "llvm.icmp"(%0, %0) <{predicate = 3 : i64}> : (i64, i64) -> i1
"llvm.return"(%1) : (i1) -> ()
}
