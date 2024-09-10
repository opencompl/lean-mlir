module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mng_write_basi(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(255 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %4 = llvm.icmp "ugt" %3, %0 : i8
    %5 = llvm.load %arg1 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "eq" %5, %1 : i16
    %7 = llvm.icmp "eq" %5, %2 : i16
    %8 = llvm.select %4, %7, %6 : i1, i1
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
