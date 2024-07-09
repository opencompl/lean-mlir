module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @initval() {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<12xi8>) : !llvm.array<12 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)> 
    llvm.return %5 : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)>
  }
  llvm.func @function(%arg0: i32, %arg1: i32, %arg2: i32) -> !llvm.struct<(i64, i64)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant(dense<0> : tensor<12xi8>) : !llvm.array<12 x i8>
    %4 = llvm.mlir.undef : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)> 
    %7 = llvm.mlir.addressof @initval : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.getelementptr inbounds %7[%8, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)>
    %10 = llvm.mlir.constant(6 : i96) : i96
    %11 = llvm.mlir.constant(-288230376151711744 : i96) : i96
    %12 = llvm.mlir.constant(32 : i96) : i96
    %13 = llvm.mlir.constant(288230371856744448 : i96) : i96
    %14 = llvm.mlir.constant(4294967232 : i96) : i96
    %15 = llvm.mlir.constant(63 : i96) : i96
    %16 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.mlir.constant(8 : i64) : i64
    %19 = llvm.alloca %0 x !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %20 = llvm.load %7 {alignment = 1 : i64} : !llvm.ptr -> i96
    %21 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i32
    %22 = llvm.zext %arg0 : i32 to i96
    %23 = llvm.shl %22, %10 overflow<nsw, nuw>  : i96
    %24 = llvm.and %20, %11  : i96
    %25 = llvm.zext %arg1 : i32 to i96
    %26 = llvm.shl %25, %12 overflow<nsw, nuw>  : i96
    %27 = llvm.and %26, %13  : i96
    %28 = llvm.and %23, %14  : i96
    %29 = llvm.zext %arg2 : i32 to i96
    %30 = llvm.and %29, %15  : i96
    %31 = llvm.or %27, %28  : i96
    %32 = llvm.or %31, %30  : i96
    %33 = llvm.or %32, %24  : i96
    llvm.store %33, %19 {alignment = 8 : i64} : i96, !llvm.ptr
    %34 = llvm.getelementptr inbounds %19[%8, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)>
    llvm.store %21, %34 {alignment = 4 : i64} : i32, !llvm.ptr
    %35 = llvm.trunc %33 : i96 to i64
    %36 = llvm.insertvalue %35, %16[0] : !llvm.struct<(i64, i64)> 
    %37 = llvm.getelementptr inbounds %19[%8, 0, %18] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct._my_struct", packed (array<12 x i8>, array<4 x i8>)>
    %38 = llvm.load %37 {alignment = 8 : i64} : !llvm.ptr -> i64
    %39 = llvm.insertvalue %38, %36[1] : !llvm.struct<(i64, i64)> 
    llvm.return %39 : !llvm.struct<(i64, i64)>
  }
}
