module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @external_global() {addr_space = 0 : i32} : i8
  llvm.func @use_v2(vector<2xi31>)
  llvm.func @use_v3(vector<3xi16>)
  llvm.func @fshl_mask_simplify1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshr_mask_simplify2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg2, %0  : vector<2xi32>
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @fshl_mask_simplify3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshr_mask_simplify1(%arg0: i33, %arg1: i33, %arg2: i33) -> i33 {
    %0 = llvm.mlir.constant(64 : i33) : i33
    %1 = llvm.and %arg2, %0  : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshl_mask_simplify2(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(32 : i31) : i31
    %1 = llvm.mlir.constant(dense<32> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.and %arg2, %1  : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }
  llvm.func @fshr_mask_simplify3(%arg0: i33, %arg1: i33, %arg2: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.and %arg2, %0  : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshl_mask_not_required(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshl_mask_reduce_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshl_mask_negative(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshr_set_but_not_demanded_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.or %arg2, %0  : vector<2xi32>
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @fshl_set_but_not_demanded_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(32 : i31) : i31
    %1 = llvm.mlir.constant(dense<32> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.or %arg2, %1  : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }
  llvm.func @fshl_op0_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%0, %arg0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshl_op0_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%0, %arg0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshr_op0_undef(%arg0: i33) -> i33 {
    %0 = llvm.mlir.undef : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshr_op0_zero(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshl_op1_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshl_op1_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fshr_op1_undef(%arg0: i33) -> i33 {
    %0 = llvm.mlir.undef : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshr_op1_zero(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshl_op0_zero_splat_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(0 : i31) : i31
    %1 = llvm.mlir.constant(dense<0> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(7 : i31) : i31
    %3 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.intr.fshl(%1, %arg0, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }
  llvm.func @fshl_op1_undef_splat_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.undef : vector<2xi31>
    %1 = llvm.mlir.constant(7 : i31) : i31
    %2 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %0, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }
  llvm.func @fshr_op0_undef_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @fshr_op1_zero_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.intr.fshr(%arg0, %1, %2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @fshl_op0_zero_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(0 : i31) : i31
    %1 = llvm.mlir.constant(dense<0> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(33 : i31) : i31
    %3 = llvm.mlir.constant(-1 : i31) : i31
    %4 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.intr.fshl(%1, %arg0, %4)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %5 : vector<2xi31>
  }
  llvm.func @fshl_op1_undef_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.undef : vector<2xi31>
    %1 = llvm.mlir.constant(33 : i31) : i31
    %2 = llvm.mlir.constant(-1 : i31) : i31
    %3 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.intr.fshl(%arg0, %0, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }
  llvm.func @fshr_op0_undef_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @fshr_op1_zero_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.intr.fshr(%arg0, %1, %2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @fshl_only_op0_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @fshl_only_op1_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(63 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @fshr_only_op1_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.mlir.constant(12392 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }
  llvm.func @fshr_only_op0_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.mlir.constant(30 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.lshr %2, %1  : i33
    llvm.return %3 : i33
  }
  llvm.func @fshl_only_op1_demanded_vec_splat(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(7 : i31) : i31
    %1 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(31 : i31) : i31
    %3 = llvm.mlir.constant(63 : i31) : i31
    %4 = llvm.mlir.constant(dense<[63, 31]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.intr.fshl(%arg0, %arg1, %1)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    %6 = llvm.and %5, %4  : vector<2xi31>
    llvm.return %6 : vector<2xi31>
  }
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(34 : i33) : i33
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }
  llvm.func @fshl_undef_shift_amount(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fshr_undef_shift_amount(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.undef : i33
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth_constexpr(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[34, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(-1 : i31) : i31
    %1 = llvm.mlir.constant(34 : i31) : i31
    %2 = llvm.mlir.constant(dense<[34, -1]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i31
    %2 = llvm.mlir.constant(34 : i31) : i31
    %3 = llvm.mlir.undef : vector<2xi31>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi31>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi31>
    %8 = llvm.ptrtoint %0 : !llvm.ptr to i31
    %9 = llvm.intr.fshl(%arg0, %arg1, %7)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %9 : vector<2xi31>
  }
  llvm.func @fshl_undef_shift_amount_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.undef : vector<2xi31>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %1 : vector<2xi31>
  }
  llvm.func @fshr_undef_shift_amount_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @rotl_common_demanded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @rotr_common_demanded(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(2 : i33) : i33
    %1 = llvm.mlir.constant(8 : i33) : i33
    %2 = llvm.xor %arg0, %0  : i33
    %3 = llvm.intr.fshr(%2, %2, %1)  : (i33, i33, i33) -> i33
    llvm.return %3 : i33
  }
  llvm.func @fshl_only_op1_demanded_vec_nonsplat(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(38 : i31) : i31
    %1 = llvm.mlir.constant(7 : i31) : i31
    %2 = llvm.mlir.constant(dense<[7, 38]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.mlir.constant(31 : i31) : i31
    %4 = llvm.mlir.constant(63 : i31) : i31
    %5 = llvm.mlir.constant(dense<[63, 31]> : vector<2xi31>) : vector<2xi31>
    %6 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    %7 = llvm.and %6, %5  : vector<2xi31>
    llvm.return %7 : vector<2xi31>
  }
  llvm.func @rotl_constant_shift_amount(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @rotl_constant_shift_amount_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(-1 : i31) : i31
    %1 = llvm.mlir.constant(32 : i31) : i31
    %2 = llvm.mlir.constant(dense<[32, -1]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg0, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }
  llvm.func @rotr_constant_shift_amount(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(34 : i33) : i33
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }
  llvm.func @rotr_constant_shift_amount_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[33, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @fshl_both_ops_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(192 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @fshr_both_ops_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(26 : i33) : i33
    %1 = llvm.mlir.constant(192 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }
  llvm.func @fshl_known_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(192 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.intr.fshl(%3, %4, %1)  : (i32, i32, i32) -> i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @fshr_known_bits(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(26 : i33) : i33
    %2 = llvm.mlir.constant(192 : i33) : i33
    %3 = llvm.or %arg0, %0  : i33
    %4 = llvm.lshr %arg1, %0  : i33
    %5 = llvm.intr.fshr(%3, %4, %1)  : (i33, i33, i33) -> i33
    %6 = llvm.and %5, %2  : i33
    llvm.return %6 : i33
  }
  llvm.func @fshr_multi_use(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(23 : i33) : i33
    %2 = llvm.mlir.constant(31 : i33) : i33
    %3 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    %4 = llvm.lshr %3, %1  : i33
    %5 = llvm.xor %4, %3  : i33
    %6 = llvm.and %5, %2  : i33
    llvm.return %6 : i33
  }
  llvm.func @expanded_fshr_multi_use(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(32 : i33) : i33
    %2 = llvm.mlir.constant(23 : i33) : i33
    %3 = llvm.mlir.constant(31 : i33) : i33
    %4 = llvm.lshr %arg0, %0  : i33
    %5 = llvm.shl %arg0, %1  : i33
    %6 = llvm.or %4, %5  : i33
    %7 = llvm.lshr %6, %2  : i33
    %8 = llvm.xor %7, %6  : i33
    %9 = llvm.and %8, %3  : i33
    llvm.return %9 : i33
  }
  llvm.func @fshl_bswap(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }
  llvm.func @fshr_bswap(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }
  llvm.func @fshl_bswap_vector(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<3xi16>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    llvm.return %1 : vector<3xi16>
  }
  llvm.func @fshl_bswap_wrong_op(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }
  llvm.func @fshr_bswap_wrong_amount(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }
  llvm.func @fshl_bswap_wrong_width(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fshl_mask_args_same1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @fshl_mask_args_same2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @fshl_mask_args_same3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @fshl_mask_args_different(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.mlir.constant(17 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.intr.fshl(%3, %4, %2)  : (i32, i32, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @fsh_andconst_rotate(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @fsh_orconst_rotate(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-268435456 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @fsh_rotate_5(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.shl %3, %1  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @fsh_rotate_18(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.shl %3, %1  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @fsh_load_rotate_12(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(20 : i32) : i32
    %7 = llvm.mlir.constant(12 : i32) : i32
    %8 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %9 = llvm.zext %8 : i8 to i32
    %10 = llvm.shl %9, %0 overflow<nuw>  : i32
    %11 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8
    %13 = llvm.zext %12 : i8 to i32
    %14 = llvm.shl %13, %2 overflow<nsw, nuw>  : i32
    %15 = llvm.or %14, %10  : i32
    %16 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8
    %18 = llvm.zext %17 : i8 to i32
    %19 = llvm.shl %18, %4 overflow<nsw, nuw>  : i32
    %20 = llvm.or %15, %19  : i32
    %21 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %22 = llvm.load %21 {alignment = 1 : i64} : !llvm.ptr -> i8
    %23 = llvm.zext %22 : i8 to i32
    %24 = llvm.or %20, %23  : i32
    %25 = llvm.lshr %24, %6  : i32
    %26 = llvm.shl %24, %7  : i32
    %27 = llvm.or %25, %26  : i32
    llvm.return %27 : i32
  }
  llvm.func @fsh_load_rotate_25(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(7 : i32) : i32
    %7 = llvm.mlir.constant(25 : i32) : i32
    %8 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %9 = llvm.zext %8 : i8 to i32
    %10 = llvm.shl %9, %0 overflow<nuw>  : i32
    %11 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8
    %13 = llvm.zext %12 : i8 to i32
    %14 = llvm.shl %13, %2 overflow<nsw, nuw>  : i32
    %15 = llvm.or %14, %10  : i32
    %16 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8
    %18 = llvm.zext %17 : i8 to i32
    %19 = llvm.shl %18, %4 overflow<nsw, nuw>  : i32
    %20 = llvm.or %15, %19  : i32
    %21 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %22 = llvm.load %21 {alignment = 1 : i64} : !llvm.ptr -> i8
    %23 = llvm.zext %22 : i8 to i32
    %24 = llvm.or %20, %23  : i32
    %25 = llvm.lshr %24, %6  : i32
    %26 = llvm.shl %24, %7  : i32
    %27 = llvm.or %25, %26  : i32
    llvm.return %27 : i32
  }
  llvm.func @fshr_mask_args_same_vector(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1000 : i31) : i31
    %1 = llvm.mlir.constant(dense<1000> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(-1 : i31) : i31
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.mlir.constant(10 : i31) : i31
    %5 = llvm.mlir.constant(dense<10> : vector<2xi31>) : vector<2xi31>
    %6 = llvm.and %arg0, %1  : vector<2xi31>
    %7 = llvm.and %arg0, %3  : vector<2xi31>
    %8 = llvm.intr.fshl(%7, %6, %5)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %8 : vector<2xi31>
  }
  llvm.func @fshr_mask_args_same_vector2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000000, 100000]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.intr.fshr(%3, %3, %2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @fshr_mask_args_same_vector3_different_but_still_prunable(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1000 : i31) : i31
    %1 = llvm.mlir.constant(dense<1000> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(-1 : i31) : i31
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.mlir.constant(3 : i31) : i31
    %5 = llvm.mlir.constant(10 : i31) : i31
    %6 = llvm.mlir.constant(dense<[10, 3]> : vector<2xi31>) : vector<2xi31>
    %7 = llvm.and %arg0, %1  : vector<2xi31>
    %8 = llvm.and %arg0, %3  : vector<2xi31>
    %9 = llvm.intr.fshl(%8, %7, %6)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %9 : vector<2xi31>
  }
  llvm.func @fsh_unary_shuffle_ops(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.intr.fshr(%1, %2, %3)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @fsh_unary_shuffle_ops_widening(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: vector<2xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 1] : vector<2xi16> 
    llvm.call @use_v3(%1) : (vector<3xi16>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 1] : vector<2xi16> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0, 1] : vector<2xi16> 
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<3xi16>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    llvm.return %4 : vector<3xi16>
  }
  llvm.func @fsh_unary_shuffle_ops_narrowing(%arg0: vector<3xi31>, %arg1: vector<3xi31>, %arg2: vector<3xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.poison : vector<3xi31>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xi31> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<3xi31> 
    llvm.call @use_v2(%2) : (vector<2xi31>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<3xi31> 
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }
  llvm.func @fsh_unary_shuffle_ops_unshuffled(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi32> 
    %3 = llvm.intr.fshr(%1, %2, %arg2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @fsh_unary_shuffle_ops_wrong_mask(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<2xi32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.intr.fshr(%1, %2, %3)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @fsh_unary_shuffle_ops_uses(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.poison : vector<2xi31>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%1) : (vector<2xi31>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%2) : (vector<2xi31>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%3) : (vector<2xi31>) -> ()
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }
  llvm.func @fsh_unary_shuffle_ops_partial_widening(%arg0: vector<3xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.mlir.poison : vector<2xi32>
    %2 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xi32> 
    %3 = llvm.shufflevector %arg1, %1 [1, 0] : vector<2xi32> 
    %4 = llvm.shufflevector %arg2, %1 [1, 0] : vector<2xi32> 
    %5 = llvm.intr.fshr(%2, %3, %4)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @fshr_vec_zero_elem(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
}
