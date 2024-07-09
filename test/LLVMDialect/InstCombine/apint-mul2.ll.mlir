module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i177) -> i177 {
    %0 = llvm.mlir.constant(1 : i177) : i177
    %1 = llvm.mlir.constant(155 : i177) : i177
    %2 = llvm.shl %0, %1  : i177
    %3 = llvm.mul %arg0, %2  : i177
    llvm.return %3 : i177
  }
  llvm.func @test2(%arg0: vector<2xi177>) -> vector<2xi177> {
    %0 = llvm.mlir.constant(1 : i177) : i177
    %1 = llvm.mlir.constant(dense<1> : vector<2xi177>) : vector<2xi177>
    %2 = llvm.mlir.constant(155 : i177) : i177
    %3 = llvm.mlir.constant(dense<155> : vector<2xi177>) : vector<2xi177>
    %4 = llvm.shl %1, %3  : vector<2xi177>
    %5 = llvm.mul %arg0, %4  : vector<2xi177>
    llvm.return %5 : vector<2xi177>
  }
  llvm.func @test3(%arg0: vector<2xi177>) -> vector<2xi177> {
    %0 = llvm.mlir.constant(1 : i177) : i177
    %1 = llvm.mlir.constant(dense<1> : vector<2xi177>) : vector<2xi177>
    %2 = llvm.mlir.constant(155 : i177) : i177
    %3 = llvm.mlir.constant(150 : i177) : i177
    %4 = llvm.mlir.constant(dense<[150, 155]> : vector<2xi177>) : vector<2xi177>
    %5 = llvm.shl %1, %4  : vector<2xi177>
    %6 = llvm.mul %arg0, %5  : vector<2xi177>
    llvm.return %6 : vector<2xi177>
  }
}
