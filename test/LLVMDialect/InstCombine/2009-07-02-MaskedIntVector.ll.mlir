module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i64) -> i32 {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<16xi8>) : vector<16xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.bitcast %0 : vector<4xi32> to vector<16xi8>
    %5 = llvm.shufflevector %4, %2 [0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi8> 
    %6 = llvm.bitcast %5 : vector<16xi8> to vector<2xi64>
    %7 = llvm.extractelement %6[%3 : i32] : vector<2xi64>
    %8 = llvm.bitcast %7 : i64 to vector<2xi32>
    %9 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %10 = llvm.xor %8, %9  : vector<2xi32>
    %11 = llvm.extractelement %10[%3 : i32] : vector<2xi32>
    llvm.return %11 : i32
  }
}
