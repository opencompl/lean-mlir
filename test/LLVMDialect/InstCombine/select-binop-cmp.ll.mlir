module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @use(vector<2xi1>)
  llvm.func @use2(i1)
  llvm.func @use.i32(i32)
  llvm.func @select_xor_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_meta(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_mul_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.mul %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_add_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_or_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_and_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %4 = llvm.select %2, %3, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @select_xor_icmp_vec_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.call @use(%2) : (vector<2xi1>) -> ()
    %3 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %4 = llvm.select %2, %arg1, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @select_xor_inv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_inv_icmp2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_fadd_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @select_fadd_fcmp_2_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.select %1, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @select_fadd_fcmp_3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %1, %arg0  : f32
    %4 = llvm.select %2, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @select_fadd_fcmp_3_poszero(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %1, %arg0  : f32
    %4 = llvm.select %2, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @select_fadd_fcmp_4(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_4_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_5(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %4, %arg1 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @select_fadd_fcmp_5_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.select %1, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @select_fadd_fcmp_6(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fadd %arg0, %1  : f32
    %4 = llvm.select %2, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @select_fadd_fcmp_6_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fadd %arg0, %1  : f32
    %4 = llvm.select %2, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @select_fmul_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fsub_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fsub_fcmp_negzero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fdiv_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_sub_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.sub %arg2, %arg0  : vector<2xi8>
    %4 = llvm.select %2, %3, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @select_shl_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.shl %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_lshr_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.lshr %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_ashr_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.ashr %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_udiv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sdiv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sdiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_bad_1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg3 : i32
    %1 = llvm.xor %arg0, %arg2  : i32
    %2 = llvm.select %0, %1, %arg1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @select_xor_icmp_bad_2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg3, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_bad_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_fcmp_bad_4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg3, %0 : f32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_bad_5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_bad_6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_xor_icmp_vec_bad(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %3 = llvm.select %1, %2, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @vec_select_no_equivalence(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.icmp "eq" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @select_xor_icmp_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %9 = llvm.select %7, %8, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @select_mul_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.mul %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_add_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_and_icmp_zero(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_or_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_lshr_icmp_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_lshr_icmp_const_reordered(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_exact_lshr_icmp_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_lshr_icmp_const_large_exact_range(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_lshr_icmp_const_different_values(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_fadd_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_3(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fcmp "one" %arg0, %arg3 : f32
    %1 = llvm.fadd %arg0, %arg2  : f32
    %2 = llvm.select %0, %arg1, %1 : i1, f32
    llvm.return %2 : f32
  }
  llvm.func @select_fadd_fcmp_bad_4(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_5(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_6(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_7(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_8(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @select_fadd_fcmp_bad_9(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_10(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @select_fadd_fcmp_bad_11(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @select_fadd_fcmp_bad_12(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_13(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fadd_fcmp_bad_14(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fmul_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fmul_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fmul_icmp_bad(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg3, %0 : i32
    %2 = llvm.fmul %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fmul_icmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg3, %0 : i32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fdiv_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fdiv_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fsub_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_fsub_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @select_sub_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_bad_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_bad_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_bad_4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg3  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sub_icmp_bad_5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg3 : i32
    %1 = llvm.sub %arg2, %arg0  : i32
    %2 = llvm.select %0, %1, %arg1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @select_shl_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.shl %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_lshr_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.lshr %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_ashr_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.ashr %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_udiv_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_sdiv_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_one_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_multi_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_fold(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.intr.fshr(%arg1, %arg2, %arg0)  : (i32, i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_nested(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @select_replace_nested_extra_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @select_replace_nested_no_simplify(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @select_replace_deeply_nested(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.add %3, %arg2  : i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.select %2, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_replace_constexpr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.icmp "eq" %arg0, %2 : i32
    %4 = llvm.add %arg0, %arg1  : i32
    %5 = llvm.select %3, %4, %arg2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_replace_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %8 = llvm.sub %arg0, %arg1  : vector<2xi32>
    %9 = llvm.select %7, %8, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @select_replace_call_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @call_speculatable(%arg0, %arg0) : (i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_call_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @call_non_speculatable(%arg0, %arg0) : (i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_sdiv_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_sdiv_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_udiv_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_udiv_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @select_replace_phi(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i32)
  ^bb1(%4: i32, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.add %4, %2  : i32
    %7 = llvm.icmp "eq" %4, %0 : i32
    %8 = llvm.select %7, %5, %3 : i1, i32
    llvm.call @use_i32(%8) : (i32) -> ()
    llvm.br ^bb1(%6, %4 : i32, i32)
  }
  llvm.func @call_speculatable(i32, i32) -> i32 attributes {passthrough = ["speculatable"]}
  llvm.func @call_non_speculatable(i32, i32) -> i32
  llvm.func @use_i32(i32)
}
