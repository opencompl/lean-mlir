module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s1("\01\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s11("\01\01\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s111("\01\01\01\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s000(dense<0> : tensor<4xi8>) {addr_space = 0 : i32} : !llvm.array<4 x i8>
  llvm.mlir.global external constant @s11102("\01\01\01\00\02\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s21111("\02\01\01\01\01\00") {addr_space = 0 : i32}
  llvm.func @strchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @fold_strchr_s1_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @s1 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_strchr_s11_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @s11 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_strchr_s111_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s111 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_strchr_s000_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @s000 : !llvm.ptr
    %3 = llvm.call @strchr(%2, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @xform_strchr_s21111_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\02\01\01\01\01\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s21111 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_strchr_s21111p1_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\02\01\01\01\01\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s21111 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %5 = llvm.call @strchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @fold_strchr_s11102_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\02\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s11102 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
}
