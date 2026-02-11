"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
	%0 = "llvm.sext"(%arg1) : (i1) -> i64
	%1 = "llvm.and"(%0, %arg0) : (i64, i64) -> i64
	%2 = "llvm.ashr"(%1, %arg2) : (i64, i64) -> i64
	%3 = "llvm.sdiv"(%2, %arg2) : (i64, i64) -> i64
	%4 = "llvm.udiv"(%arg0, %3) : (i64, i64) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%6 = "llvm.sext"(%5) : (i1) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%7) : (i32) -> ()
}) : () -> ()
