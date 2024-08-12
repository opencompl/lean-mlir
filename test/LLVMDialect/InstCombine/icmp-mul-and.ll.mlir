module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @mul_mask_pow2_eq0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @mul_mask_pow2_ne0_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @mul_mask_pow2_ne0_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @mul_mask_pow2_sgt0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "sgt" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @mul_mask_fakepow2_ne0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @mul_mask_pow2_eq4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @mul_mask_notpow2_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(60 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @pr40493(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mul %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @pr40493_neg1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mul %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @pr40493_neg2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mul %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @pr40493_neg3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @pr40493_vec1(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mul %arg0, %0  : vector<4xi32>
    %5 = llvm.and %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }
  llvm.func @pr40493_vec2(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.mul %arg0, %10  : vector<4xi32>
    %15 = llvm.and %14, %11  : vector<4xi32>
    %16 = llvm.icmp "eq" %15, %13 : vector<4xi32>
    llvm.return %16 : vector<4xi1>
  }
  llvm.func @pr40493_vec3(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.mul %arg0, %0  : vector<4xi32>
    %15 = llvm.and %14, %11  : vector<4xi32>
    %16 = llvm.icmp "eq" %15, %13 : vector<4xi32>
    llvm.return %16 : vector<4xi1>
  }
  llvm.func @pr40493_vec4(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %0, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %23 = llvm.mul %arg0, %10  : vector<4xi32>
    %24 = llvm.and %23, %20  : vector<4xi32>
    %25 = llvm.icmp "eq" %24, %22 : vector<4xi32>
    llvm.return %25 : vector<4xi1>
  }
  llvm.func @pr40493_vec5(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[12, 12, 20, 20]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[2, 4, 2, 4]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mul %arg0, %0  : vector<4xi32>
    %5 = llvm.and %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }
  llvm.func @pr51551(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.mul %5, %arg0 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    llvm.return %8 : i1
  }
  llvm.func @pr51551_2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.or %3, %1  : i32
    %5 = llvm.mul %4, %arg0 overflow<nsw>  : i32
    %6 = llvm.and %5, %1  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @pr51551_neg1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.mul %5, %arg0 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    llvm.return %8 : i1
  }
  llvm.func @pr51551_neg2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-7 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.mul %3, %arg0 overflow<nsw>  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @pr51551_demand3bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.or %3, %1  : i32
    %5 = llvm.mul %4, %arg0 overflow<nsw>  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
}
