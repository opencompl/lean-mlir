module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fls(i16) -> i16
  llvm.func @sink(i16)
  llvm.func @fold_fls(%arg0: i16) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.call @fls(%0) : (i16) -> i16
    llvm.call @sink(%2) : (i16) -> ()
    %3 = llvm.call @fls(%1) : (i16) -> i16
    llvm.call @sink(%3) : (i16) -> ()
    %4 = llvm.call @fls(%arg0) : (i16) -> i16
    llvm.call @sink(%4) : (i16) -> ()
    llvm.return
  }
}
