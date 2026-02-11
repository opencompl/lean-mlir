"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
	%0 = "llvm.udiv"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%2 = "llvm.lshr"(%arg2, %0) : (i64, i64) -> i64
	%3 = "llvm.select"(%1, %arg2, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%4 = "llvm.sdiv"(%arg0, %2) : (i64, i64) -> i64
	%5 = "llvm.select"(%arg1, %3, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%6 = "llvm.sdiv"(%arg0, %5) : (i64, i64) -> i64
	"llvm.return"(%6) : (i64) -> ()
}) : () -> ()
