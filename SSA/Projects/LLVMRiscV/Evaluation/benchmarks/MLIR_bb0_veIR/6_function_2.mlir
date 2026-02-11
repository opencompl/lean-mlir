"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i32):
	%0 = "llvm.zext"(%arg1) : (i32) -> i64
	%1 = "llvm.srem"(%0, %0) : (i64, i64) -> i64
	%2 = "llvm.udiv"(%1, %0) : (i64, i64) -> i64
	%3 = "llvm.ashr"(%2, %arg0) : (i64, i64) -> i64
	%4 = "llvm.or"(%arg0, %3) : (i64, i64) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%5) : (i1) -> ()
}) : () -> ()
