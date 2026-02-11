"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1):
	%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%1 = "llvm.zext"(%0) : (i32) -> i64
	%2 = "llvm.ashr"(%1, %arg0) : (i64, i64) -> i64
	%3 = "llvm.urem"(%1, %2) : (i64, i64) -> i64
	%4 = "llvm.zext"(%arg1) : (i1) -> i64
	%5 = "llvm.icmp"(%3, %4) <{predicate = 6 : i64}> : (i64, i64) -> i1
	"llvm.return"(%5) : (i1) -> ()
}) : () -> ()
