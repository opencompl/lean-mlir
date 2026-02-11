"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.xor"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.sdiv"(%0, %arg0) : (i64, i64) -> i64
	%2 = "llvm.udiv"(%1, %1) : (i64, i64) -> i64
	%3 = "llvm.urem"(%2, %arg1) : (i64, i64) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%4) : (i32) -> ()
}) : () -> ()
