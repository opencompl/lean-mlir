"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.sdiv"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.udiv"(%0, %arg2) : (i64, i64) -> i64
	%2 = "llvm.and"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.udiv"(%0, %2) : (i64, i64) -> i64
	%4 = "llvm.ashr"(%arg1, %arg0) : (i64, i64) -> i64
	%5 = "llvm.xor"(%3, %4) : (i64, i64) -> i64
	%6 = "llvm.udiv"(%5, %arg0) : (i64, i64) -> i64
	%7 = "llvm.icmp"(%2, %6) <{predicate = 7 : i64}> : (i64, i64) -> i1
	"llvm.return"(%7) : (i1) -> ()
}) : () -> ()
