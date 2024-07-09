module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @trunc_add_nsw(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<17> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @trunc_add_no_nsw(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @trunc_add_mixed(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[17, 16, 17, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
}
