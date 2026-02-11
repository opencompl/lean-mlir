"builtin.module"() ({
	^bb0(%arg0: i1):
	%0 = "llvm.zext"(%arg0) : (i1) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%2 = "llvm.sext"(%1) : (i1) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%3) : (i32) -> ()
}) : () -> ()
