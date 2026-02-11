"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.srem"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.urem"(%0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.srem"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.urem"(%2, %arg2) : (i64, i64) -> i64
	%4 = "llvm.icmp"(%arg0, %3) <{predicate = 4 : i64}> : (i64, i64) -> i1
	%5 = "llvm.select"(%4, %0, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%6) : (i1) -> ()
}) : () -> ()
