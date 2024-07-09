module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i1)
  llvm.func @basic(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.getelementptr inbounds %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @partialConstant1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%arg1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @partialConstant2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @merge(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @nested(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<3xi32>
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.mul %arg1, %arg2  : i64
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, vector<5xi32>
    %6 = llvm.getelementptr inbounds %5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %7 = llvm.getelementptr inbounds %6[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<4xi32>
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @multipleUses1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @multipleUses2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @multipleUses3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
}
