"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i32, %arg2: i64):
	%0 = "llvm.sext"(%arg0) : (i1) -> i64
	%1 = "llvm.sext"(%arg1) : (i32) -> i64
	%2 = "llvm.or"(%arg2, %0) : (i64, i64) -> i64
	%3 = "llvm.sdiv"(%2, %0) : (i64, i64) -> i64
	%4 = "llvm.srem"(%3, %2) : (i64, i64) -> i64
	%5 = "llvm.and"(%1, %4) : (i64, i64) -> i64
	%6 = "llvm.sdiv"(%0, %5) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%7) : (i1) -> ()
}) : () -> ()
