"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i32):
	%0 = "llvm.sext"(%arg0) : (i1) -> i64
	%1 = "llvm.udiv"(%arg1, %arg2) : (i64, i64) -> i64
	%2 = "llvm.xor"(%0, %1) : (i64, i64) -> i64
	%3 = "llvm.and"(%2, %2) : (i64, i64) -> i64
	%4 = "llvm.sext"(%arg3) : (i32) -> i64
	%5 = "llvm.udiv"(%3, %4) : (i64, i64) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%6) : (i1) -> ()
}) : () -> ()
