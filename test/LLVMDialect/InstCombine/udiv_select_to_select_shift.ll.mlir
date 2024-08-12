module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.select %arg1, %0, %1 : i1, i64
    %4 = llvm.udiv %arg0, %3  : i64
    %5 = llvm.select %arg1, %1, %2 : i1, i64
    %6 = llvm.udiv %arg0, %5  : i64
    %7 = llvm.add %4, %6  : i64
    llvm.return %7 : i64
  }
  llvm.func @PR34856(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-7> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    %6 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    %7 = llvm.udiv %arg1, %6  : vector<2xi32>
    %8 = llvm.add %7, %5  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
}
