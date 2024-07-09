module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: f32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.poison : vector<8xi32>
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.load %arg1 {alignment = 32 : i64} : !llvm.ptr -> vector<8xf32>
    %4 = llvm.bitcast %3 : vector<8xf32> to vector<8xi32>
    %5 = llvm.bitcast %4 : vector<8xi32> to vector<8xf32>
    %6 = llvm.fptosi %5 : vector<8xf32> to vector<8xi32>
    %7 = llvm.fptosi %arg0 : f32 to i32
    %8 = llvm.add %7, %0  : i32
    %9 = llvm.extractelement %6[%8 : i32] : vector<8xi32>
    %10 = llvm.insertelement %9, %1[%2 : i32] : vector<8xi32>
    %11 = llvm.sitofp %10 : vector<8xi32> to vector<8xf32>
    llvm.store %11, %arg1 {alignment = 32 : i64} : vector<8xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.bitcast %0 : vector<2xi64> to vector<4xi32>
    %2 = llvm.extractelement %1[%arg0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }
}
