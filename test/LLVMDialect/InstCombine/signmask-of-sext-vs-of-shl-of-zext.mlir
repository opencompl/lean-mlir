module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @t0(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @n2(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @n3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @n4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-1073741824 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t5(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @n6(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @n7(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t8(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.shl %2, %0  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @t9(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %9 = llvm.shl %8, %6  : vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @t10_undef(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %9 = llvm.shl %8, %0  : vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @t10_poison(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %9 = llvm.shl %8, %0  : vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @t11(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(-2147483648 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.shl %13, %6  : vector<2xi32>
    %15 = llvm.and %14, %12  : vector<2xi32>
    llvm.return %15 : vector<2xi32>
  }
}
