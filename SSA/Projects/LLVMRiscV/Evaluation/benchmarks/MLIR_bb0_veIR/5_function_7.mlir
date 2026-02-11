"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.and"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.urem"(%arg0, %0) : (i64, i64) -> i64
	%2 = "llvm.and"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.ashr"(%arg1, %arg2) : (i64, i64) -> i64
	%4 = "llvm.icmp"(%2, %3) <{predicate = 8 : i64}> : (i64, i64) -> i1
	"llvm.return"(%4) : (i1) -> ()
}) : () -> ()
