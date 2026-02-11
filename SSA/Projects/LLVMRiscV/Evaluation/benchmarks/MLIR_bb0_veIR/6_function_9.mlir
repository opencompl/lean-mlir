"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.and"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%2 = "llvm.sext"(%1) : (i32) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%4 = "llvm.sext"(%3) : (i1) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%5) : (i1) -> ()
}) : () -> ()
