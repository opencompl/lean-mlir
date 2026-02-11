"builtin.module"() ({
	^bb0(%arg0: i64):
	%0 = "llvm.and"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.and"(%0, %arg0) : (i64, i64) -> i64
	%2 = "llvm.trunc"(%1) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%2) : (i1) -> ()
}) : () -> ()
