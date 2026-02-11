"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i1, %arg3: i32):
	%0 = "llvm.zext"(%arg2) : (i1) -> i64
	%1 = "llvm.srem"(%arg1, %0) : (i64, i64) -> i64
	%2 = "llvm.xor"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.sext"(%arg3) : (i32) -> i64
	%4 = "llvm.icmp"(%2, %3) <{predicate = 5 : i64}> : (i64, i64) -> i1
	"llvm.return"(%4) : (i1) -> ()
}) : () -> ()
