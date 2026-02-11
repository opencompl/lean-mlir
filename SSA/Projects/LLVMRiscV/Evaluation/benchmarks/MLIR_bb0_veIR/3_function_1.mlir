"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i32):
	%0 = "llvm.zext"(%arg1) : (i32) -> i64
	%1 = "llvm.sdiv"(%arg0, %0) : (i64, i64) -> i64
	%2 = "llvm.icmp"(%arg0, %1) <{predicate = 6 : i64}> : (i64, i64) -> i1
	"llvm.return"(%2) : (i1) -> ()
}) : () -> ()
