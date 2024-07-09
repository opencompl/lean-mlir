module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(1024 : i17) : i17
    %1 = llvm.mul %arg0, %0  : i17
    llvm.return %1 : i17
  }
  llvm.func @test2(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(1024 : i17) : i17
    %1 = llvm.mlir.constant(dense<1024> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mul %arg0, %1  : vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }
  llvm.func @test3(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(256 : i17) : i17
    %1 = llvm.mlir.constant(1024 : i17) : i17
    %2 = llvm.mlir.constant(dense<[1024, 256]> : vector<2xi17>) : vector<2xi17>
    %3 = llvm.mul %arg0, %2  : vector<2xi17>
    llvm.return %3 : vector<2xi17>
  }
}
