"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
	%0 = "llvm.ashr"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.select"(%arg1, %0, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%2 = "llvm.lshr"(%0, %1) : (i64, i64) -> i64
	"llvm.return"(%2) : (i64) -> ()
}) : () -> ()
