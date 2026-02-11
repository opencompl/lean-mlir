"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.lshr"(%arg1, %arg1) : (i64, i64) -> i64
	%1 = "llvm.udiv"(%arg0, %0) : (i64, i64) -> i64
	%2 = "llvm.srem"(%0, %arg2) : (i64, i64) -> i64
	%3 = "llvm.sdiv"(%1, %2) : (i64, i64) -> i64
	%4 = "llvm.lshr"(%3, %arg1) : (i64, i64) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%6 = "llvm.zext"(%5) : (i32) -> i64
	"llvm.return"(%6) : (i64) -> ()
}) : () -> ()
