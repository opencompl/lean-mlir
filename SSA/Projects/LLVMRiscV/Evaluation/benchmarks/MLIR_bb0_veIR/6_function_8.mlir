"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
	%0 = "llvm.select"(%arg0, %arg1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%1 = "llvm.udiv"(%arg1, %arg2) : (i64, i64) -> i64
	%2 = "llvm.sdiv"(%arg1, %1) : (i64, i64) -> i64
	%3 = "llvm.urem"(%arg2, %2) : (i64, i64) -> i64
	%4 = "llvm.lshr"(%0, %3) : (i64, i64) -> i64
	%5 = "llvm.udiv"(%4, %2) : (i64, i64) -> i64
	"llvm.return"(%5) : (i64) -> ()
}) : () -> ()
