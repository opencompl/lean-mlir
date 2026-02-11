"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1):
	%0 = "llvm.sdiv"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.or"(%arg1, %arg0) : (i64, i64) -> i64
	%2 = "llvm.select"(%arg3, %arg2, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%3 = "llvm.ashr"(%arg2, %2) : (i64, i64) -> i64
	%4 = "llvm.sdiv"(%1, %3) : (i64, i64) -> i64
	%5 = "llvm.and"(%0, %4) : (i64, i64) -> i64
	%6 = "llvm.ashr"(%5, %0) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%7) : (i32) -> ()
}) : () -> ()
