"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.and"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%2 = "llvm.sext"(%1) : (i32) -> i64
	%3 = "llvm.lshr"(%arg0, %arg1) : (i64, i64) -> i64
	%4 = "llvm.srem"(%2, %3) : (i64, i64) -> i64
	%5 = "llvm.udiv"(%2, %4) : (i64, i64) -> i64
	"llvm.return"(%5) : (i64) -> ()
}) : () -> ()
