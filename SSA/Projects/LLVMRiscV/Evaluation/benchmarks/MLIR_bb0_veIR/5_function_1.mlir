"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.urem"(%0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.trunc"(%1) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%3 = "llvm.zext"(%2) : (i1) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%4) : (i1) -> ()
}) : () -> ()
