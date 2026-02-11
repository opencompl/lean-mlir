"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1):
	%0 = "llvm.sext"(%arg1) : (i1) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%2 = "llvm.zext"(%1) : (i1) -> i64
	%3 = "llvm.urem"(%arg0, %2) : (i64, i64) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%5 = "llvm.sext"(%4) : (i32) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%6) : (i32) -> ()
}) : () -> ()
