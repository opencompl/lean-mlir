module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: vector<4xi32>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : vector<4xi32> to vector<4xi64>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi64>
    llvm.store %2, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %2, %arg2 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
}
