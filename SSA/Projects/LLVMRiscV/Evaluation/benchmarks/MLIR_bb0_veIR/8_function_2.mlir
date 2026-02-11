"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64):
	%0 = "llvm.sext"(%arg0) : (i1) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%2 = "llvm.sext"(%1) : (i32) -> i64
	%3 = "llvm.srem"(%0, %arg1) : (i64, i64) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%5 = "llvm.sext"(%4) : (i32) -> i64
	%6 = "llvm.or"(%2, %5) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%7) : (i32) -> ()
}) : () -> ()
