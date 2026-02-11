"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.and"(%arg0, %arg0) : (i64, i64) -> i64
	%1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%2 = "llvm.zext"(%1) : (i1) -> i64
	%3 = "llvm.urem"(%2, %arg1) : (i64, i64) -> i64
	%4 = "llvm.icmp"(%3, %arg1) <{predicate = 4 : i64}> : (i64, i64) -> i1
	%5 = "llvm.zext"(%4) : (i1) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%6) : (i1) -> ()
}) : () -> ()
