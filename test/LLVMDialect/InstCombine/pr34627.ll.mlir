module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @patatino() -> vector<2xi16> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.getelementptr inbounds %0[%1, %2] : (!llvm.ptr, i16, vector<2xi16>) -> !llvm.vec<2 x ptr>, !llvm.array<1 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.vec<2 x ptr> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }
}
