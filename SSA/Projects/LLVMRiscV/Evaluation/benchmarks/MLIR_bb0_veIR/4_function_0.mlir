"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.xor"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.srem"(%arg1, %arg1) : (i64, i64) -> i64
	%2 = "llvm.urem"(%0, %1) : (i64, i64) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%3) : (i1) -> ()
}) : () -> ()
