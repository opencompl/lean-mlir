module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i1)
  llvm.func @use32(i32)
  llvm.func @PR1817_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @PR1817_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @PR1817_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @PR1817_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @PR2330(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.icmp "ult" %arg1, %0 : i32
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @PR2330_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg1, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(51 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(51 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @and_ne_with_one_bit_diff_constants1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(51 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @and_ne_with_one_bit_diff_constants1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(51 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @and_ne_with_one_bit_diff_constants2(%arg0: i19) -> i1 {
    %0 = llvm.mlir.constant(65 : i19) : i19
    %1 = llvm.mlir.constant(193 : i19) : i19
    %2 = llvm.icmp "ne" %arg0, %0 : i19
    %3 = llvm.icmp "ne" %arg0, %1 : i19
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @and_ne_with_one_bit_diff_constants2_logical(%arg0: i19) -> i1 {
    %0 = llvm.mlir.constant(65 : i19) : i19
    %1 = llvm.mlir.constant(193 : i19) : i19
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i19
    %4 = llvm.icmp "ne" %arg0, %1 : i19
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants3_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @and_ne_with_one_bit_diff_constants3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @and_ne_with_one_bit_diff_constants3_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.icmp "ne" %arg0, %1 : i8
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @or_eq_with_diff_one(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mlir.constant(14 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @or_eq_with_diff_one_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mlir.constant(14 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @and_ne_with_diff_one(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(40 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @and_ne_with_diff_one_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(40 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @or_eq_with_diff_one_signed(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @or_eq_with_diff_one_signed_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @and_ne_with_diff_one_signed(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg0, %1 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @and_ne_with_diff_one_signed_logical(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i64
    %4 = llvm.icmp "ne" %arg0, %1 : i64
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @or_eq_with_one_bit_diff_constants2_splatvec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<97> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @and_ne_with_diff_one_splatvec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<39> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @simplify_before_foldAndOfICmps(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.undef : i16
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.load %7 {alignment = 2 : i64} : !llvm.ptr -> i16
    %9 = llvm.getelementptr %7[%1] : (!llvm.ptr, i8) -> !llvm.ptr, i16
    %10 = llvm.udiv %8, %2  : i16
    %11 = llvm.getelementptr %7[%10] : (!llvm.ptr, i16) -> !llvm.ptr, i16
    %12 = llvm.load %11 {alignment = 2 : i64} : !llvm.ptr -> i16
    %13 = llvm.load %11 {alignment = 2 : i64} : !llvm.ptr -> i16
    %14 = llvm.mul %10, %10  : i16
    %15 = llvm.load %7 {alignment = 2 : i64} : !llvm.ptr -> i16
    %16 = llvm.sdiv %8, %15  : i16
    %17 = llvm.sub %3, %16  : i16
    %18 = llvm.mul %14, %17  : i16
    %19 = llvm.icmp "ugt" %13, %10 : i16
    %20 = llvm.and %8, %12  : i16
    %21 = llvm.mul %19, %4  : i1
    %22 = llvm.icmp "sle" %16, %13 : i16
    %23 = llvm.icmp "ule" %16, %13 : i16
    %24 = llvm.icmp "slt" %20, %3 : i16
    %25 = llvm.srem %15, %18  : i16
    %26 = llvm.add %24, %19  : i1
    %27 = llvm.add %23, %26  : i1
    %28 = llvm.icmp "sge" %23, %27 : i1
    %29 = llvm.or %25, %15  : i16
    %30 = llvm.icmp "uge" %22, %21 : i1
    %31 = llvm.icmp "ult" %30, %28 : i1
    llvm.store %5, %9 {alignment = 2 : i64} : i16, !llvm.ptr
    %32 = llvm.icmp "ule" %19, %24 : i1
    %33 = llvm.getelementptr %6[%31] : (!llvm.ptr, i1) -> !llvm.ptr, i1
    llvm.store %29, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %32, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.store %33, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @PR42691_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "uge" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "uge" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_8_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_9_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR42691_10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR42691_10_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @substitute_constant_and_eq_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_and_eq_eq_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_and_eq_eq_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_and_eq_eq_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_and_eq_ugt_swap(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_and_eq_ugt_swap_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_and_eq_ne_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @substitute_constant_and_eq_ne_vec_logical(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %4 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi8>
    %5 = llvm.select %3, %4, %2 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @substitute_constant_and_eq_sgt_use(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_and_eq_sgt_use_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_and_eq_sgt_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_and_eq_sgt_use2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_and_ne_ugt_swap(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_and_ne_ugt_swap_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_or_ne_swap_sle(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_or_ne_swap_sle_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "sle" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_or_ne_uge_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_or_ne_uge_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "uge" %arg0, %arg1 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_or_ne_slt_swap_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @substitute_constant_or_ne_slt_swap_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @substitute_constant_or_ne_slt_swap_vec_logical(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(true) : i1
    %8 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %9 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %10 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %11 = llvm.select %9, %8, %10 : vector<2xi1>, vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @substitute_constant_or_eq_swap_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ne" %arg1, %arg0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_or_eq_swap_ne_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_or_ne_sge_use(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_or_ne_sge_use_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sge" %arg0, %arg1 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @substitute_constant_or_ne_ule_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @substitute_constant_or_ne_ule_use2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_ranges_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(20 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "uge" %arg0, %1 : i8
    %7 = llvm.icmp "ule" %arg0, %2 : i8
    %8 = llvm.and %6, %7  : i1
    %9 = llvm.or %5, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @or_ranges_adjacent(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.or %6, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @or_ranges_separated(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.or %6, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @or_ranges_single_elem_right(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "eq" %arg0, %2 : i8
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_ranges_single_elem_left(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "eq" %arg0, %2 : i8
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @and_ranges_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.and %6, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @and_ranges_overlap_single(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(20 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "uge" %arg0, %1 : i8
    %7 = llvm.icmp "ule" %arg0, %2 : i8
    %8 = llvm.and %6, %7  : i1
    %9 = llvm.and %5, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @and_ranges_no_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.and %6, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @and_ranges_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.mlir.constant(1024 : i64) : i64
    %2 = llvm.mlir.constant(128 : i64) : i64
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.add %arg0, %0  : i64
    %5 = llvm.icmp "slt" %4, %1 : i64
    %6 = llvm.add %arg0, %2  : i64
    %7 = llvm.icmp "slt" %6, %3 : i64
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @and_two_ranges_to_mask_and_range(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(25 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @and_two_ranges_to_mask_and_range_not_pow2_diff(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(25 : i8) : i8
    %2 = llvm.mlir.constant(-64 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @and_two_ranges_to_mask_and_range_different_sizes(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(25 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.mlir.constant(24 : i8) : i8
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ugt" %6, %3 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @and_two_ranges_to_mask_and_range_no_add_on_one_range(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.mlir.constant(28 : i16) : i16
    %3 = llvm.icmp "uge" %arg0, %0 : i16
    %4 = llvm.icmp "ult" %arg0, %1 : i16
    %5 = llvm.icmp "uge" %arg0, %2 : i16
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.and %3, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @is_ascii_alphabetic(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65 : i32) : i32
    %1 = llvm.mlir.constant(26 : i32) : i32
    %2 = llvm.mlir.constant(-97 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2 overflow<nsw>  : i32
    %7 = llvm.icmp "ult" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @is_ascii_alphabetic_inverted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-91 : i32) : i32
    %1 = llvm.mlir.constant(-26 : i32) : i32
    %2 = llvm.mlir.constant(-123 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2 overflow<nsw>  : i32
    %7 = llvm.icmp "ult" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @bitwise_and_bitwise_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %3, %7  : i1
    %10 = llvm.and %9, %8  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_and_bitwise_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %3, %7  : i1
    %10 = llvm.and %8, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_and_bitwise_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %7, %3  : i1
    %10 = llvm.and %9, %8  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_and_bitwise_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %7, %3  : i1
    %10 = llvm.and %8, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_and_logical_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.and %10, %9  : i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_and_logical_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.and %9, %10  : i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_and_logical_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.and %10, %9  : i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_and_logical_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.and %9, %10  : i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_bitwise_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %4, %8  : i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_bitwise_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %4, %8  : i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_bitwise_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %8, %4  : i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_bitwise_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %8, %4  : i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_logical_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_logical_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_logical_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_and_logical_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_or_bitwise_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %3, %7  : i1
    %10 = llvm.or %9, %8  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_or_bitwise_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %3, %7  : i1
    %10 = llvm.or %8, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_or_bitwise_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %7, %3  : i1
    %10 = llvm.or %9, %8  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_or_bitwise_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %7, %3  : i1
    %10 = llvm.or %8, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @bitwise_or_logical_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.or %10, %9  : i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_or_logical_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.or %9, %10  : i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_or_logical_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.or %10, %9  : i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_or_logical_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.or %9, %10  : i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_bitwise_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %4, %8  : i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_bitwise_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %4, %8  : i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_bitwise_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %8, %4  : i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_bitwise_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %8, %4  : i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_logical_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_logical_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_logical_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @logical_or_logical_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_asymmetric(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(11 : i32) : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %arg0, %2 : i1, i1
    %7 = llvm.and %arg1, %3  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %arg0, %2 : i1, i1
    %7 = llvm.and %arg1, %3  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros_poison1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %arg0, %1 : i1, i1
    %6 = llvm.and %arg1, %2  : i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros_poison2(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.select %4, %arg0, %2 : i1, i1
    %6 = llvm.and %arg1, %arg2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_allones(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %arg0, %1 : i1, i1
    %6 = llvm.and %arg1, %2  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_allones_poison1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.and %arg1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %arg2 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i1
    %5 = llvm.and %arg1, %1  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @bitwise_and_logical_and_masked_icmp_allones_poison2(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.select %3, %arg0, %1 : i1, i1
    %5 = llvm.and %arg1, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %arg2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @samesign(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_different_sign_bittest1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "sle" %1, %0 : vector<2xi32>
    %3 = llvm.or %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %5 = llvm.or %2, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @samesign_different_sign_bittest2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @samesign_commute1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %5, %3  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_commute2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_commute3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %5, %3  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_violate_constraint1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_violate_constraint2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_mult_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_mult_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_mult_use3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_wrong_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_different_sign_bittest1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @samesign_inverted_different_sign_bittest2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @samesign_inverted_commute1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %5, %3  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_commute2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_commute3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %5, %3  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_violate_constraint1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_violate_constraint2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_mult_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_mult_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @samesign_inverted_wrong_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_eq_m1_and_eq_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi8>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_eq_m1_and_eq_poison_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %13 = llvm.icmp "eq" %arg1, %11 : vector<2xi8>
    %14 = llvm.and %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @icmp_eq_poison_and_eq_m1_m2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %3 = llvm.icmp "eq" %arg1, %1 : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @icmp_ne_m1_and_ne_m1_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "ne" %arg1, %6 : vector<2xi8>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_eq_m1_or_eq_m1_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_ne_m1_or_ne_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    %9 = llvm.icmp "ne" %arg1, %7 : vector<2xi8>
    %10 = llvm.or %8, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %1 : i1 to i32
    %4 = llvm.zext %2 : i1 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.ashr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.ashr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64x2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "sgt" %arg0, %1 : vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi1> to vector<2xi64>
    %5 = llvm.zext %3 : vector<2xi1> to vector<2xi64>
    %6 = llvm.or %4, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64x2_fail(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi64>
    %3 = llvm.lshr %arg0, %1  : vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi1> to vector<2xi64>
    %5 = llvm.or %3, %4  : vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_sge_neg1_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_sge_100_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @ashr_and_icmp_sge_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_and_icmp_sgt_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i64_fail(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32x2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    %4 = llvm.lshr %arg0, %1  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32x2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    %4 = llvm.lshr %arg0, %1  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_xor_icmp_sgt_neg2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_and_icmp_ne_neg2_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_xor_icmp_sge_neg2_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @icmp_slt_0_or_icmp_add_1_sge_100_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "sge" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.lshr %arg0, %2  : i32
    %7 = llvm.or %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @logical_and_icmps1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(10086 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    %5 = llvm.icmp "slt" %arg0, %2 : i32
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @logical_and_icmps2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(10086 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    %5 = llvm.icmp "eq" %arg0, %2 : i32
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @logical_and_icmps_vec1(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %3 = llvm.mlir.constant(dense<10086> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.icmp "sgt" %arg0, %0 : vector<4xi32>
    %5 = llvm.select %arg1, %4, %2 : vector<4xi1>, vector<4xi1>
    %6 = llvm.icmp "slt" %arg0, %3 : vector<4xi32>
    %7 = llvm.select %5, %6, %2 : vector<4xi1>, vector<4xi1>
    llvm.return %7 : vector<4xi1>
  }
  llvm.func @logical_and_icmps_fail1(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %arg2, %2, %1 : i1, i1
    %4 = llvm.icmp "slt" %arg0, %arg1 : i32
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
}
