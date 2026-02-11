"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.trunc"(%arg1) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%1 = "llvm.zext"(%0) : (i32) -> i64
	%2 = "llvm.xor"(%arg1, %1) : (i64, i64) -> i64
	%3 = "llvm.lshr"(%2, %arg1) : (i64, i64) -> i64
	%4 = "llvm.lshr"(%arg0, %3) : (i64, i64) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%5) : (i32) -> ()
}) : () -> ()
