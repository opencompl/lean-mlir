"builtin.module"() ({
	^bb0(%arg0: i32, %arg1: i64):
	%0 = "llvm.zext"(%arg0) : (i32) -> i64
	%1 = "llvm.xor"(%0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.lshr"(%0, %1) : (i64, i64) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%3) : (i32) -> ()
}) : () -> ()
