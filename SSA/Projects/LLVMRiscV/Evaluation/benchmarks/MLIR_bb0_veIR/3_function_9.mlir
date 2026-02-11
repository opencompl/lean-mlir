"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64):
	%0 = "llvm.udiv"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.lshr"(%arg0, %0) : (i64, i64) -> i64
	%2 = "llvm.urem"(%arg0, %1) : (i64, i64) -> i64
	"llvm.return"(%2) : (i64) -> ()
}) : () -> ()
