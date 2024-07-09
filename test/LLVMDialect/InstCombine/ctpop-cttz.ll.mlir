module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ctpop1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @ctpop1v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.or %2, %arg0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ctpop1_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.add %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @ctpop2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %arg0, %1  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @ctpop2v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ctpop2_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %arg0, %1  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @ctpop3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @ctpop3v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    %6 = llvm.intr.ctpop(%5)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @ctpop3v_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.sub %1, %arg0  : vector<2xi32>
    %10 = llvm.and %9, %arg0  : vector<2xi32>
    %11 = llvm.add %10, %8  : vector<2xi32>
    %12 = llvm.intr.ctpop(%11)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %12 : vector<2xi32>
  }
}
