module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @m_387(%arg0: !llvm.ptr {llvm.noalias, llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}, %arg2: vector<4xi1>) -> vector<4xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : i32
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
    %14 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %15 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %16 = llvm.sext %arg2 : vector<4xi1> to vector<4xi32>
    %17 = llvm.xor %16, %0  : vector<4xi32>
    %18 = llvm.and %17, %11  : vector<4xi32>
    %19 = llvm.or %18, %13  : vector<4xi32>
    %20 = llvm.bitcast %19 : vector<4xi32> to vector<4xf32>
    %21 = llvm.shufflevector %15, %20 [0, 1, 2, 7] : vector<4xf32> 
    llvm.return %21 : vector<4xf32>
  }
}
