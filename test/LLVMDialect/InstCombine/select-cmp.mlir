module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.return %2 : i1
  }
  llvm.func @icmp_ne_common_op00(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i6
    %1 = llvm.icmp "ne" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ne_common_op01(%arg0: i1, %arg1: i3, %arg2: i3, %arg3: i3) -> i1 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i3
    %1 = llvm.icmp "ne" %arg3, %arg1 : i3
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ne_common_op10(%arg0: i1, %arg1: i4, %arg2: i4, %arg3: i4) -> i1 {
    %0 = llvm.icmp "ne" %arg2, %arg1 : i4
    %1 = llvm.icmp "ne" %arg1, %arg3 : i4
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ne_common_op11(%arg0: vector<3xi1>, %arg1: vector<3xi17>, %arg2: vector<3xi17>, %arg3: vector<3xi17>) -> vector<3xi1> {
    %0 = llvm.icmp "ne" %arg2, %arg1 : vector<3xi17>
    %1 = llvm.icmp "ne" %arg3, %arg1 : vector<3xi17>
    %2 = llvm.select %arg0, %0, %1 : vector<3xi1>, vector<3xi1>
    llvm.return %2 : vector<3xi1>
  }
  llvm.func @icmp_eq_common_op00(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i1 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i5
    %1 = llvm.icmp "eq" %arg1, %arg3 : i5
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_eq_common_op01(%arg0: vector<5xi1>, %arg1: vector<5xi7>, %arg2: vector<5xi7>, %arg3: vector<5xi7>) -> vector<5xi1> {
    %0 = llvm.icmp "eq" %arg1, %arg2 : vector<5xi7>
    %1 = llvm.icmp "eq" %arg3, %arg1 : vector<5xi7>
    %2 = llvm.select %arg0, %0, %1 : vector<5xi1>, vector<5xi1>
    llvm.return %2 : vector<5xi1>
  }
  llvm.func @icmp_eq_common_op10(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i32
    %1 = llvm.icmp "eq" %arg1, %arg3 : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_eq_common_op11(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i64
    %1 = llvm.icmp "eq" %arg3, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_common_one_use_1(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.icmp "eq" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_slt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg2 : i6
    %1 = llvm.icmp "slt" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_sgt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg2 : i6
    %1 = llvm.icmp "sgt" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_sle_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sle" %arg2, %arg1 : i6
    %1 = llvm.icmp "sle" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_sge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sge" %arg2, %arg1 : i6
    %1 = llvm.icmp "sge" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_slt_sgt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg2 : i6
    %1 = llvm.icmp "sgt" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_sle_sge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sle" %arg2, %arg1 : i6
    %1 = llvm.icmp "sge" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ult_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg2 : i6
    %1 = llvm.icmp "ult" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ule_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ule" %arg2, %arg1 : i6
    %1 = llvm.icmp "ule" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ugt_common(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg2, %arg1 : i8
    %1 = llvm.icmp "ugt" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_uge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "uge" %arg2, %arg1 : i6
    %1 = llvm.icmp "uge" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ult_ugt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg2 : i6
    %1 = llvm.icmp "ugt" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_ule_uge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ule" %arg2, %arg1 : i6
    %1 = llvm.icmp "uge" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_common_pred_different(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    %1 = llvm.icmp "ne" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_common_pred_not_swap(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg1 : i8
    %1 = llvm.icmp "sle" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_common_pred_not_commute_pred(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg1 : i8
    %1 = llvm.icmp "sgt" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_common_one_use_0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.icmp "eq" %arg3, %arg1 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @icmp_no_common(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "eq" %arg3, %arg1 : i8
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test_select_inverse_eq(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test_select_inverse_signed(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test_select_inverse_unsigned(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(11 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.icmp "ugt" %arg0, %1 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test_select_inverse_eq_ptr(%arg0: !llvm.ptr, %arg1: i1) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test_select_inverse_fail(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test_select_inverse_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    %4 = llvm.select %arg1, %2, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test_select_inverse_vec_fail(%arg0: vector<2xi64>, %arg1: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    %4 = llvm.select %arg1, %2, %3 : i1, vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test_select_inverse_nonconst1(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test_select_inverse_nonconst2(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg1, %arg0 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test_select_inverse_nonconst3(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test_select_inverse_nonconst4(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg2, %arg1 : i64
    %2 = llvm.select %arg3, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @use(i1)
}
