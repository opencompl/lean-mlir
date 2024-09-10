module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655765 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    %6 = llvm.add %arg0, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }
  llvm.func @test0_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.xor %3, %1  : vector<4xi32>
    %5 = llvm.add %4, %2 overflow<nsw>  : vector<4xi32>
    %6 = llvm.add %arg0, %5 overflow<nsw>  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %5, %0 overflow<nsw>  : i32
    %7 = llvm.add %arg0, %6 overflow<nsw>  : i32
    llvm.return %7 : i32
  }
  llvm.func @test1_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.ashr %arg0, %0  : vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    %5 = llvm.xor %4, %2  : vector<4xi32>
    %6 = llvm.add %5, %0 overflow<nsw>  : vector<4xi32>
    %7 = llvm.add %arg0, %6 overflow<nsw>  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
}
