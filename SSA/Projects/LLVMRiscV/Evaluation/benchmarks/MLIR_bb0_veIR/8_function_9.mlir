"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.xor"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.xor"(%0, %0) : (i64, i64) -> i64
	%2 = "llvm.ashr"(%arg0, %arg1) : (i64, i64) -> i64
	%3 = "llvm.udiv"(%arg2, %1) : (i64, i64) -> i64
	%4 = "llvm.sdiv"(%2, %3) : (i64, i64) -> i64
	%5 = "llvm.or"(%1, %4) : (i64, i64) -> i64
	%6 = "llvm.srem"(%5, %4) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%7) : (i32) -> ()
}) : () -> ()
