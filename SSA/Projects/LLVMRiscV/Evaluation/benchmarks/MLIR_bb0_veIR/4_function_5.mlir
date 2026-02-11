"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
	%0 = "llvm.srem"(%arg1, %arg1) : (i64, i64) -> i64
	%1 = "llvm.select"(%arg0, %0, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%2 = "llvm.xor"(%1, %arg1) : (i64, i64) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%3) : (i1) -> ()
}) : () -> ()
