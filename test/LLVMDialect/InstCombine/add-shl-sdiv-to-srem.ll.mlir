module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @"add-shl-sdiv-scalar0"(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }
  llvm.func @"add-shl-sdiv-scalar1"(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }
  llvm.func @"add-shl-sdiv-scalar2"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1073741824 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @"add-shl-sdiv-splat0"(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-4> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shl %2, %1  : vector<3xi8>
    %4 = llvm.add %3, %arg0  : vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }
  llvm.func @"add-shl-sdiv-splat1"(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1073741824> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %2, %1  : vector<4xi32>
    %4 = llvm.add %3, %arg0  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @"add-shl-sdiv-splat2"(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.shl %2, %1  : vector<2xi64>
    %4 = llvm.add %3, %arg0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @use32(i32)
  llvm.func @"add-shl-sdiv-i32-4-use0"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    llvm.call @use32(%arg0) : (i32) -> ()
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @"add-shl-sdiv-i32-use1"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @"add-shl-sdiv-i32-use2"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @"add-shl-sdiv-i32-use3"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @use3xi8(vector<3xi8>)
  llvm.func @"add-shl-sdiv-use4"(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-4> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    llvm.call @use3xi8(%2) : (vector<3xi8>) -> ()
    %3 = llvm.shl %2, %1  : vector<3xi8>
    %4 = llvm.add %3, %arg0  : vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }
  llvm.func @"add-shl-sdiv-negative0"(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }
  llvm.func @"add-shl-sdiv-negative1"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @"add-shl-sdiv-negative2"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @"add-shl-sdiv-negative3"(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-5> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shl %2, %1  : vector<3xi8>
    %4 = llvm.add %3, %arg0  : vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }
  llvm.func @"add-shl-sdiv-negative4"(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.shl %2, %1  : vector<2xi64>
    %4 = llvm.add %3, %arg0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @"add-shl-sdiv-3xi8-undef0"(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<2> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.sdiv %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    %12 = llvm.add %11, %arg0  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @"add-shl-sdiv-3xi8-undef1"(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-4> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    %12 = llvm.add %11, %arg0  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @"add-shl-sdiv-nonsplat0"(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[-32, -64]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.shl %2, %1  : vector<2xi64>
    %4 = llvm.add %3, %arg0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @"add-shl-sdiv-nonsplat1"(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<-4> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<[2, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shl %2, %1  : vector<3xi8>
    %4 = llvm.add %3, %arg0  : vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }
}
