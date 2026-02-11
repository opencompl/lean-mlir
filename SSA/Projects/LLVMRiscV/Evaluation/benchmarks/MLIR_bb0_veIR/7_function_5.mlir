"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.srem"(%arg1, %arg2) : (i64, i64) -> i64
	%1 = "llvm.srem"(%arg0, %0) : (i64, i64) -> i64
	%2 = "llvm.icmp"(%arg0, %1) <{predicate = 8 : i64}> : (i64, i64) -> i1
	%3 = "llvm.select"(%2, %0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%4 = "llvm.sdiv"(%arg2, %arg0) : (i64, i64) -> i64
	%5 = "llvm.select"(%2, %3, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%6) : (i32) -> ()
}) : () -> ()
