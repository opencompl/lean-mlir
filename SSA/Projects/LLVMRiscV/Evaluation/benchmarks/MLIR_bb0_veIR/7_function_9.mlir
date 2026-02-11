"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.icmp"(%arg0, %arg1) <{predicate = 3 : i64}> : (i64, i64) -> i1
	%1 = "llvm.zext"(%0) : (i1) -> i64
	%2 = "llvm.trunc"(%1) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%3 = "llvm.udiv"(%arg1, %1) : (i64, i64) -> i64
	%4 = "llvm.select"(%2, %3, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%5 = "llvm.udiv"(%arg0, %4) : (i64, i64) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%6) : (i32) -> ()
}) : () -> ()
