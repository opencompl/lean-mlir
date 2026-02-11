"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.xor"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.lshr"(%arg2, %arg1) : (i64, i64) -> i64
	%2 = "llvm.and"(%0, %1) : (i64, i64) -> i64
	%3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%4 = "llvm.sext"(%3) : (i32) -> i64
	%5 = "llvm.icmp"(%4, %arg1) <{predicate = 5 : i64}> : (i64, i64) -> i1
	"llvm.return"(%5) : (i1) -> ()
}) : () -> ()
