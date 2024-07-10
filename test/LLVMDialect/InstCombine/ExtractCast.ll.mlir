module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @a(%arg0: vector<4xi64>) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.trunc %arg0 : vector<4xi64> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }
  llvm.func @b(%arg0: vector<4xf32>) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.fptosi %arg0 : vector<4xf32> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }
}
