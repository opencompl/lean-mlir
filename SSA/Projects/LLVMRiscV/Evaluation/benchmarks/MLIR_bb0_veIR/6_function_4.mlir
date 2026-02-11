"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i32):
	%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%1 = "llvm.sext"(%0) : (i1) -> i64
	%2 = "llvm.srem"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.sext"(%arg1) : (i32) -> i64
	%4 = "llvm.sdiv"(%2, %3) : (i64, i64) -> i64
	%5 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%5) : (i32) -> ()
}) : () -> ()
