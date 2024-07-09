module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g_127() {addr_space = 0 : i32} : i32
  llvm.func @func_56(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i16 {llvm.signext}) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1734012817166602727 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.addressof @g_127 : !llvm.ptr
    %4 = llvm.mlir.undef : i32
    %5 = llvm.call @rshift_s_s(%arg2, %0) vararg(!llvm.func<i32 (...)>) : (i32, i32) -> i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.or %1, %6  : i64
    %8 = llvm.srem %7, %2  : i64
    %9 = llvm.icmp "eq" %8, %2 : i64
    %10 = llvm.zext %9 : i1 to i32
    llvm.store %10, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i32
  }
  llvm.func @rshift_s_s(...) -> i32
}
