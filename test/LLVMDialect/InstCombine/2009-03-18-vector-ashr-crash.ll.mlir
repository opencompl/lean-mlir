module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @<<INVALID EMPTY SYMBOL>>(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(dense<5> : vector<4xi16>) : vector<4xi16>
    %3 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi16>
    %5 = llvm.ashr %4, %2  : vector<4xi16>
    %6 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %5, %6 {alignment = 1 : i64} : vector<4xi16>, !llvm.ptr
    llvm.return
  }
}
