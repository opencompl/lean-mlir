module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @var_7() {addr_space = 0 : i32, alignment = 1 : i64} : i8
  llvm.mlir.global external @var_1() {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global external @var_0() {addr_space = 0 : i32, alignment = 2 : i64} : i16
  llvm.mlir.global external @var_5() {addr_space = 0 : i32, alignment = 8 : i64} : i64
  llvm.mlir.global external @arr_2() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.array<0 x i32>
  llvm.mlir.global external @arr_4() {addr_space = 0 : i32, alignment = 2 : i64} : !llvm.array<0 x i16>
  llvm.mlir.global external @arr_3() {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<8 x i32>
  llvm.func @_Z4testv() {
    %0 = llvm.mlir.addressof @var_7 : !llvm.ptr
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.addressof @var_1 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @var_0 : !llvm.ptr
    %5 = llvm.mlir.addressof @var_5 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.addressof @arr_2 : !llvm.ptr
    %8 = llvm.mlir.addressof @arr_4 : !llvm.ptr
    %9 = llvm.mlir.addressof @arr_3 : !llvm.ptr
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr inbounds %7[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %13 = llvm.getelementptr inbounds %8[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i16>
    %14 = llvm.getelementptr inbounds %9[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i32>
    %15 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %16 = llvm.icmp "eq" %15, %1 : i8
    %17 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %18 = llvm.icmp "eq" %17, %3 : i32
    %19 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %20 = llvm.sext %19 : i16 to i64
    %21 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> i64
    %22 = llvm.select %18, %21, %20 : i1, i64
    %23 = llvm.sext %19 : i16 to i32
    llvm.cond_br %16, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %19, %8 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %23, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %6, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %19, %13 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %23, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %24 = llvm.trunc %22 : i64 to i32
    llvm.store %24, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %19, %8 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %23, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %24, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %19, %13 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %23, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }
  llvm.func @diff_types_same_width_merge(%arg0: i1, %arg1: f16, %arg2: i16) -> f16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f16 {alignment = 2 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 2 : i64} : f16, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> f16
    llvm.return %2 : f16
  }
  llvm.func @diff_types_diff_width_no_merge(%arg0: i1, %arg1: i32, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @vec_no_merge(%arg0: i1, %arg1: vector<2xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", (f16)> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 2 : i64} : !llvm.struct<"struct.half", (f16)>, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : f16, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> !llvm.struct<"struct.half", (f16)>
    llvm.return %2 : !llvm.struct<"struct.half", (f16)>
  }
  llvm.func @multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", (f16, i32)> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : !llvm.struct<"struct.tup", (f16, i32)>, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : f16, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"struct.tup", (f16, i32)>
    llvm.return %2 : !llvm.struct<"struct.tup", (f16, i32)>
  }
  llvm.func @same_types_diff_align_no_merge(%arg0: i1, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i16 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : i16, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 4 : i64} : i16, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16
    llvm.return %2 : i16
  }
  llvm.func @ptrtoint_merge(%arg0: i1, %arg1: i64, %arg2: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.return %2 : i64
  }
  llvm.func @inttoptr_merge(%arg0: i1, %arg1: i64, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @pr46688(%arg0: i1, %arg1: i32, %arg2: i16, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.zext %arg2 : i16 to i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.lshr %3, %arg1  : i32
    %5 = llvm.lshr %4, %arg1  : i32
    %6 = llvm.trunc %5 : i32 to i16
    llvm.store %6, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr
    %7 = llvm.and %5, %0  : i32
    llvm.store %7, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %8 = llvm.zext %arg2 : i16 to i32
    %9 = llvm.lshr %8, %arg1  : i32
    %10 = llvm.lshr %9, %arg1  : i32
    %11 = llvm.lshr %10, %arg1  : i32
    %12 = llvm.lshr %11, %arg1  : i32
    %13 = llvm.trunc %12 : i32 to i16
    llvm.store %13, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %12, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }
}
