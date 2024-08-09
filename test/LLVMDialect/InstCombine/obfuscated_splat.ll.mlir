module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_undef(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    %2 = llvm.shufflevector %1, %0 [0, 0, -1, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %2, %1 [0, 1, 4, -1] : vector<4xf32> 
    %4 = llvm.shufflevector %3, %1 [0, 1, 2, 4] : vector<4xf32> 
    llvm.store %4, %arg1 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @test_poison(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    %2 = llvm.shufflevector %1, %0 [0, 0, -1, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %2, %1 [0, 1, 4, -1] : vector<4xf32> 
    %4 = llvm.shufflevector %3, %1 [0, 1, 2, 4] : vector<4xf32> 
    llvm.store %4, %arg1 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    llvm.return
  }
}
