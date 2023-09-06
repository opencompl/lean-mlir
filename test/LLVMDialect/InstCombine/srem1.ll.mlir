module  {
  llvm.mlir.global external @g_127() : i32
  llvm.func @func_56(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i16) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.addressof @g_127 : !llvm.ptr<i32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(-1734012817166602727 : i64) : i64
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.call @rshift_s_s(%arg2, %4) : (i32, i32) -> i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.or %3, %6  : i64
    %8 = llvm.srem %7, %2  : i64
    %9 = llvm.icmp "eq" %8, %2 : i64
    %10 = llvm.zext %9 : i1 to i32
    llvm.store %10, %1 : !llvm.ptr<i32>
    llvm.return %0 : i32
  }
  llvm.func @rshift_s_s(...) -> i32
}
