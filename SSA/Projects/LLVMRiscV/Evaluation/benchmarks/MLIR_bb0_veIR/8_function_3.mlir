"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
	%0 = "llvm.select"(%arg1, %arg2, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%1 = "llvm.udiv"(%arg0, %0) : (i64, i64) -> i64
	%2 = "llvm.srem"(%1, %0) : (i64, i64) -> i64
	%3 = "llvm.urem"(%arg0, %2) : (i64, i64) -> i64
	%4 = "llvm.and"(%arg2, %3) : (i64, i64) -> i64
	%5 = "llvm.or"(%4, %3) : (i64, i64) -> i64
	%6 = "llvm.or"(%3, %5) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%7) : (i32) -> ()
}) : () -> ()
