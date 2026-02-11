"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.icmp"(%0, %arg1) <{predicate = 0 : i64}> : (i64, i64) -> i1
	%2 = "llvm.select"(%1, %arg2, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%3 = "llvm.xor"(%arg0, %2) : (i64, i64) -> i64
	%4 = "llvm.srem"(%3, %arg1) : (i64, i64) -> i64
	"llvm.return"(%4) : (i64) -> ()
}) : () -> ()
