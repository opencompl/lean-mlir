"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
	%0 = "llvm.and"(%arg1, %arg2) : (i64, i64) -> i64
	%1 = "llvm.xor"(%0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.urem"(%arg1, %arg1) : (i64, i64) -> i64
	%3 = "llvm.select"(%arg0, %1, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	"llvm.return"(%3) : (i64) -> ()
}) : () -> ()
