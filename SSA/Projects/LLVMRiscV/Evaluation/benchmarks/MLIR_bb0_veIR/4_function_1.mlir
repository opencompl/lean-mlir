"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%1 = "llvm.sext"(%0) : (i32) -> i64
	%2 = "llvm.ashr"(%1, %arg1) : (i64, i64) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%3) : (i32) -> ()
}) : () -> ()
