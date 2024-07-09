module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @scalar_i8_shl_and_negC_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %arg0, %arg1  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @scalar_i16_shl_and_negC_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.shl %arg0, %arg1  : i16
    %3 = llvm.and %2, %0  : i16
    %4 = llvm.icmp "eq" %3, %1 : i16
    llvm.return %4 : i1
  }
  llvm.func @scalar_i32_shl_and_negC_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-262144 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @scalar_i64_shl_and_negC_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-8589934592 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.shl %arg0, %arg1  : i64
    %3 = llvm.and %2, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    llvm.return %4 : i1
  }
  llvm.func @scalar_i32_shl_and_negC_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-262144 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @vec_4xi32_shl_and_negC_eq(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %4 = llvm.and %3, %0  : vector<4xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<4xi32>
    llvm.return %5 : vector<4xi1>
  }
  llvm.func @vec_shl_and_negC_eq_poison1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %13 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %14 = llvm.and %13, %10  : vector<4xi32>
    %15 = llvm.icmp "eq" %14, %12 : vector<4xi32>
    llvm.return %15 : vector<4xi1>
  }
  llvm.func @vec_shl_and_negC_eq_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %13 = llvm.and %12, %0  : vector<4xi32>
    %14 = llvm.icmp "eq" %13, %11 : vector<4xi32>
    llvm.return %14 : vector<4xi1>
  }
  llvm.func @vec_shl_and_negC_eq_poison3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-8 : i32) : i32
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
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %22 = llvm.and %21, %10  : vector<4xi32>
    %23 = llvm.icmp "eq" %22, %20 : vector<4xi32>
    llvm.return %23 : vector<4xi1>
  }
  llvm.func @scalar_shl_and_negC_eq_extra_use_shl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.and %2, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @scalar_shl_and_negC_eq_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.mul %3, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @scalar_shl_and_negC_eq_extra_use_shl_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.add %2, %arg2  : i32
    llvm.store %4, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @scalar_i32_shl_and_negC_eq_X_is_constant1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @scalar_i32_shl_and_negC_eq_X_is_constant2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @scalar_i32_shl_and_negC_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @scalar_i32_shl_and_negC_eq_nonzero(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
}
