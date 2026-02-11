"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.or"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.ashr"(%0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.icmp"(%0, %1) <{predicate = 3 : i64}> : (i64, i64) -> i1
	"llvm.return"(%2) : (i1) -> ()
}) : () -> ()
