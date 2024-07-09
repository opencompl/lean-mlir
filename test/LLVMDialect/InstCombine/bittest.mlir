module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @b_rec.0() {addr_space = 0 : i32} : i32
  llvm.func @_Z12h000007_testv(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @b_rec.0 : !llvm.ptr
    %1 = llvm.mlir.constant(-989855744 : i32) : i32
    %2 = llvm.mlir.constant(-805306369 : i32) : i32
    %3 = llvm.mlir.constant(-973078529 : i32) : i32
    %4 = llvm.mlir.constant(-1073741824 : i32) : i32
    %5 = llvm.mlir.constant(100663295 : i32) : i32
    %6 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.or %6, %1  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.and %7, %3  : i32
    llvm.store %9, %0 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.bitcast %8 : i32 to i32
    %11 = llvm.and %10, %4  : i32
    %12 = llvm.icmp "eq" %11, %4 : i32
    llvm.cond_br %12, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %13 = llvm.bitcast %8 : i32 to i32
    %14 = llvm.and %13, %5  : i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @abort()
}
