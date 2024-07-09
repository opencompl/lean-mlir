module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i24, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mergeBasic(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @mergeDifferentTypes(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @mergeReverse(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @zeroSum(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @array1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<20 x i8>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @array2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %3 = llvm.getelementptr inbounds %2[%1, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @struct1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @struct2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-128 : i64) : i64
    %3 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.A", (array<123 x i8>, i32)>
    %4 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @structStruct(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.getelementptr inbounds %arg0[%0, 2, 0, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.B", (i8, array<3 x i16>, struct<"struct.A", (array<123 x i8>, i32)>, f32)>
    %6 = llvm.getelementptr inbounds %5[%0, 0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.A", (array<123 x i8>, i32)>
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @appendIndex(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.B", (i8, array<3 x i16>, struct<"struct.A", (array<123 x i8>, i32)>, f32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @notDivisible(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i24
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @partialConstant2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @partialConstant3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.getelementptr inbounds %2[%3, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @partialConstantMemberAliasing1(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @partialConstantMemberAliasing2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @partialConstantMemberAliasing3(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
}
