module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(4096 : i33) : i33
    %1 = llvm.urem %arg0, %0  : i33
    llvm.return %1 : i33
  }
  llvm.func @test2(%arg0: i49) -> i49 {
    %0 = llvm.mlir.constant(4096 : i49) : i49
    %1 = llvm.mlir.constant(11 : i49) : i49
    %2 = llvm.shl %0, %1  : i49
    %3 = llvm.urem %arg0, %2  : i49
    llvm.return %3 : i49
  }
  llvm.func @test3(%arg0: i59, %arg1: i1) -> i59 {
    %0 = llvm.mlir.constant(70368744177664 : i59) : i59
    %1 = llvm.mlir.constant(4096 : i59) : i59
    %2 = llvm.select %arg1, %0, %1 : i1, i59
    %3 = llvm.urem %arg0, %2  : i59
    llvm.return %3 : i59
  }
}
