module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t1_vec_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %arg1  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @t2_vec_poison0(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.xor %arg0, %10  : vector<4xi32>
    %13 = llvm.add %12, %arg1  : vector<4xi32>
    %14 = llvm.add %13, %11  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }
  llvm.func @t3_vec_poison1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.xor %arg0, %0  : vector<4xi32>
    %13 = llvm.add %12, %arg1  : vector<4xi32>
    %14 = llvm.add %13, %11  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }
  llvm.func @t4_vec_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.xor %arg0, %10  : vector<4xi32>
    %22 = llvm.add %21, %arg1  : vector<4xi32>
    %23 = llvm.add %22, %20  : vector<4xi32>
    llvm.return %23 : vector<4xi32>
  }
  llvm.func @use32(i32)
  llvm.func @t5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @gen32() -> i32
  llvm.func @t8_commutative0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @t9_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t10_commutative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
}
