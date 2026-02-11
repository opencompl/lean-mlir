"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1):
	%0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.lshr"(%0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.and"(%1, %arg2) : (i64, i64) -> i64
	%3 = "llvm.urem"(%arg0, %0) : (i64, i64) -> i64
	%4 = "llvm.select"(%arg3, %3, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%5 = "llvm.and"(%2, %4) : (i64, i64) -> i64
	%6 = "llvm.or"(%2, %5) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%7) : (i1) -> ()
}) : () -> ()
