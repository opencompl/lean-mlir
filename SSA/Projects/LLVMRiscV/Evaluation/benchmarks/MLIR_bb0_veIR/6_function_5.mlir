"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
	%0 = "llvm.select"(%arg0, %arg1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%1 = "llvm.srem"(%arg2, %0) : (i64, i64) -> i64
	%2 = "llvm.urem"(%1, %arg2) : (i64, i64) -> i64
	%3 = "llvm.icmp"(%0, %2) <{predicate = 6 : i64}> : (i64, i64) -> i1
	%4 = "llvm.select"(%3, %1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%5) : (i1) -> ()
}) : () -> ()
