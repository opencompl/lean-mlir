"builtin.module"() ({
	^bb0(%arg0: i64):
	%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%1 = "llvm.sext"(%0) : (i1) -> i64
	%2 = "llvm.trunc"(%1) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%2) : (i32) -> ()
}) : () -> ()
