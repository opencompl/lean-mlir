"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.and"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.urem"(%arg0, %arg1) : (i64, i64) -> i64
	%2 = "llvm.srem"(%0, %1) : (i64, i64) -> i64
	%3 = "llvm.icmp"(%2, %arg1) <{predicate = 3 : i64}> : (i64, i64) -> i1
	"llvm.return"(%3) : (i1) -> ()
}) : () -> ()
