"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.ashr"(%arg1, %arg0) : (i64, i64) -> i64
	%1 = "llvm.icmp"(%arg0, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
	%2 = "llvm.zext"(%1) : (i1) -> i64
	"llvm.return"(%2) : (i64) -> ()
}) : () -> ()
