"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
	%0 = "llvm.and"(%arg2, %arg0) : (i64, i64) -> i64
	%1 = "llvm.ashr"(%0, %arg0) : (i64, i64) -> i64
	%2 = "llvm.select"(%arg1, %1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%3 = "llvm.and"(%arg0, %2) : (i64, i64) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%4) : (i32) -> ()
}) : () -> ()
