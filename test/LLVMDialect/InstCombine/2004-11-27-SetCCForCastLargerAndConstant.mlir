module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @a() {addr_space = 0 : i32} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.mlir.global common @b(dense<0> : tensor<1xi32>) {addr_space = 0 : i32} : !llvm.array<1 x i32>
  llvm.func @lt_signed_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @PR28011(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.sext %arg0 : i16 to i32
    %7 = llvm.icmp "ne" %2, %4 : !llvm.ptr
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.or %8, %5  : i32
    %10 = llvm.icmp "ne" %6, %9 : i32
    llvm.return %10 : i1
  }
  llvm.func @lt_signed_to_large_unsigned_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1024, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @lt_signed_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_signed_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_signed_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_signed_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_unsigned_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_unsigned_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_unsigned_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_unsigned_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_unsigned_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lt_unsigned_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_signed_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_signed_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_signed_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_signed_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_signed_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_unsigned_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_unsigned_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_unsigned_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_unsigned_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_unsigned_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @gt_unsigned_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @different_size_zext_zext_ugt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ugt" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_zext_zext_ugt_commute(%arg0: vector<2xi4>, %arg1: vector<2xi7>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi4> to vector<2xi25>
    %1 = llvm.zext %arg1 : vector<2xi7> to vector<2xi25>
    %2 = llvm.icmp "ugt" %0, %1 : vector<2xi25>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @different_size_zext_zext_ult(%arg0: i4, %arg1: i7) -> i1 {
    %0 = llvm.zext %arg0 : i4 to i25
    %1 = llvm.zext %arg1 : i7 to i25
    %2 = llvm.icmp "ult" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_zext_zext_eq(%arg0: i4, %arg1: i7) -> i1 {
    %0 = llvm.zext %arg0 : i4 to i25
    %1 = llvm.zext %arg1 : i7 to i25
    %2 = llvm.icmp "eq" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_zext_zext_ne_commute(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ne" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_zext_zext_slt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "slt" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_zext_zext_sgt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "sgt" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_sext_sgt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "sgt" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_sext_sle(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "sle" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_sext_eq(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "eq" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_sext_ule(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_zext_ne(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ne" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @use(i25)
  llvm.func @different_size_sext_sext_ule_extra_use1(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    llvm.call @use(%1) : (i25) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_sext_ule_extra_use2(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }
  llvm.func @different_size_sext_sext_ule_extra_use3(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i25
    llvm.call @use(%1) : (i25) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }
}
