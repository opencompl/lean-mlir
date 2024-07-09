module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @add(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @add_nuw_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @add_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, -1, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @add_nuw_nsw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @shl_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @shl_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @shl_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @lshr_constant_op0(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @lshr_exact_constant_op0(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @lshr_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @lshr_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @lshr_constant_op1(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @ashr(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.ashr %arg0, %0  : vector<3xi32>
    %2 = llvm.shufflevector %1, %arg0 [3, 1, 2] : vector<3xi32> 
    llvm.return %2 : vector<3xi32>
  }
  llvm.func @and(%arg0: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(13 : i42) : i42
    %1 = llvm.mlir.constant(12 : i42) : i42
    %2 = llvm.mlir.constant(11 : i42) : i42
    %3 = llvm.mlir.constant(dense<[11, 12, 13]> : vector<3xi42>) : vector<3xi42>
    %4 = llvm.and %arg0, %3  : vector<3xi42>
    %5 = llvm.shufflevector %arg0, %4 [0, 4, -1] : vector<3xi42> 
    llvm.return %5 : vector<3xi42>
  }
  llvm.func @use_v4i32(vector<4xi32>)
  llvm.func @or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.or %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [4, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%1) : (vector<4xi32>) -> ()
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @xor(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @udiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @udiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @udiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @udiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @sdiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @sdiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @sdiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @sdiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @urem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @urem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @srem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.srem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @fadd_maybe_nan(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @fsub(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.fsub %0, %arg0  : vector<4xf64>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @fdiv_constant_op0(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf64>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @fdiv_constant_op1(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf64>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @frem(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.frem %0, %arg0  : vector<4xf64>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @add_add(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @add_add_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.add %arg0, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @add_add_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, -1, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @add_add_nsw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.add %arg0, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, -1, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_sub_nuw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg0 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_sub_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_sub_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg0 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_shl_nuw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_shl_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_shl_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @lshr_lshr(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @ashr_ashr(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.ashr %arg0, %0  : vector<3xi32>
    %3 = llvm.ashr %arg0, %1  : vector<3xi32>
    %4 = llvm.shufflevector %2, %3 [3, 1, 2] : vector<3xi32> 
    llvm.return %4 : vector<3xi32>
  }
  llvm.func @and_and(%arg0: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(3 : i42) : i42
    %1 = llvm.mlir.constant(2 : i42) : i42
    %2 = llvm.mlir.constant(1 : i42) : i42
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi42>) : vector<3xi42>
    %4 = llvm.mlir.constant(6 : i42) : i42
    %5 = llvm.mlir.constant(5 : i42) : i42
    %6 = llvm.mlir.constant(4 : i42) : i42
    %7 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi42>) : vector<3xi42>
    %8 = llvm.and %arg0, %3  : vector<3xi42>
    %9 = llvm.and %arg0, %7  : vector<3xi42>
    %10 = llvm.shufflevector %8, %9 [0, 4, -1] : vector<3xi42> 
    llvm.return %10 : vector<3xi42>
  }
  llvm.func @or_or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @xor_xor(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.xor %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @udiv_udiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_sdiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_sdiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_sdiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_sdiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @urem_urem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.urem %0, %arg0  : vector<4xi32>
    %3 = llvm.urem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @urem_urem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.urem %0, %arg0  : vector<4xi32>
    %3 = llvm.urem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @srem_srem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @srem_srem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @fadd_fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg0, %1  : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @fsub_fsub(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fsub %0, %arg0  : vector<4xf64>
    %3 = llvm.fsub %1, %arg0  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @fmul_fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>
    %3 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @fdiv_fdiv(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf64>
    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @frem_frem(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.frem %0, %arg0  : vector<4xf64>
    %3 = llvm.frem %arg0, %1  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @add_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_2_vars_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sub_2_vars_nsw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_2_vars_nuw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_2_vars_nuw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_2_vars_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.shl %arg1, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_2_vars_nsw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.shl %arg1, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @lshr_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @lshr_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @lshr_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @lshr_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @ashr_2_vars(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.ashr %arg0, %0  : vector<3xi32>
    %3 = llvm.ashr %arg1, %1  : vector<3xi32>
    %4 = llvm.shufflevector %2, %3 [3, 1, 2] : vector<3xi32> 
    llvm.return %4 : vector<3xi32>
  }
  llvm.func @and_2_vars(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(3 : i42) : i42
    %1 = llvm.mlir.constant(2 : i42) : i42
    %2 = llvm.mlir.constant(1 : i42) : i42
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi42>) : vector<3xi42>
    %4 = llvm.mlir.constant(6 : i42) : i42
    %5 = llvm.mlir.constant(5 : i42) : i42
    %6 = llvm.mlir.constant(4 : i42) : i42
    %7 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi42>) : vector<3xi42>
    %8 = llvm.and %arg0, %3  : vector<3xi42>
    %9 = llvm.and %arg1, %7  : vector<3xi42>
    %10 = llvm.shufflevector %8, %9 [0, 4, -1] : vector<3xi42> 
    llvm.return %10 : vector<3xi42>
  }
  llvm.func @or_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    %3 = llvm.or %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @or_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    %3 = llvm.or %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @xor_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    %3 = llvm.xor %arg1, %1  : vector<4xi32>
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @udiv_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @udiv_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @udiv_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @udiv_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @sdiv_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @urem_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.urem %0, %arg0  : vector<4xi32>
    %3 = llvm.urem %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @srem_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @fadd_2_vars(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @fsub_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fsub %0, %arg0  : vector<4xf64>
    %3 = llvm.fsub %1, %arg1  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @fmul_2_vars(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @frem_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.frem %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf64>
    %3 = llvm.frem %1, %arg1  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @fdiv_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fdiv %0, %arg0  : vector<4xf64>
    %3 = llvm.fdiv %arg1, %1  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @mul_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, -1, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_is_nop_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_mul_not_constant_shift_amount(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %0, %arg0  : vector<4xi32>
    %3 = llvm.mul %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_shl_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg1, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @shl_mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.mul %arg1, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, -1, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mul_neg(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.mlir.constant(257 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.mul %arg0, %12  : vector<4xi32>
    %24 = llvm.sub %22, %arg0  : vector<4xi32>
    %25 = llvm.shufflevector %23, %24 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %25 : vector<4xi32>
  }
  llvm.func @neg_mul(%arg0: vector<3xi79>) -> vector<3xi79> {
    %0 = llvm.mlir.constant(0 : i79) : i79
    %1 = llvm.mlir.poison : i79
    %2 = llvm.mlir.undef : vector<3xi79>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi79>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi79>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi79>
    %9 = llvm.mlir.constant(-3 : i79) : i79
    %10 = llvm.mlir.undef : vector<3xi79>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : vector<3xi79>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %9, %12[%13 : i32] : vector<3xi79>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<3xi79>
    %17 = llvm.sub %8, %arg0 overflow<nsw>  : vector<3xi79>
    %18 = llvm.mul %arg0, %16 overflow<nsw>  : vector<3xi79>
    %19 = llvm.shufflevector %17, %18 [0, 4, 2] : vector<3xi79> 
    llvm.return %19 : vector<3xi79>
  }
  llvm.func @mul_neg_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %12, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %1, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.mul %arg0, %11 overflow<nuw>  : vector<4xi32>
    %23 = llvm.sub %21, %arg1 overflow<nsw>  : vector<4xi32>
    %24 = llvm.shufflevector %22, %23 [0, 5, 6, 3] : vector<4xi32> 
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @neg_mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.constant(42 : i32) : i32
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %11, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.sub %10, %arg1 overflow<nsw>  : vector<4xi32>
    %23 = llvm.mul %arg0, %21 overflow<nsw, nuw>  : vector<4xi32>
    %24 = llvm.shufflevector %22, %23 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @add_or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[65534, 65535, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.or %3, %2  : vector<4xi32>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @add_or_disjoint(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[65534, 65535, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @or_add(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.lshr %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = llvm.add %3, %2 overflow<nsw, nuw>  : vector<4xi8>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi8> 
    llvm.return %6 : vector<4xi8>
  }
  llvm.func @or_add_not_enough_masking(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.lshr %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = llvm.add %3, %2 overflow<nsw, nuw>  : vector<4xi8>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi8> 
    llvm.return %6 : vector<4xi8>
  }
  llvm.func @add_or_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[65534, 65535, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %0  : vector<4xi32>
    %4 = llvm.add %arg1, %1  : vector<4xi32>
    %5 = llvm.or %3, %2  : vector<4xi32>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @or_add_2_vars(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.lshr %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = llvm.add %arg1, %2 overflow<nsw, nuw>  : vector<4xi8>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi8> 
    llvm.return %6 : vector<4xi8>
  }
  llvm.func @PR41419(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @sel_common_op_commute0(%arg0: vector<5xi4>, %arg1: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 6, 2, 3, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %arg0, %0 [0, 6, 7, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @sel_common_op_commute1(%arg0: vector<5xi4>, %arg1: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg1, %arg0 [0, 6, 2, 3, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %arg0, %0 [0, 6, 7, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @sel_common_op_commute2(%arg0: vector<5xi4>, %arg1: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 6, 2, 3, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %0, %arg0 [0, 6, 7, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @sel_common_op_commute3(%arg0: vector<5xi4>, %arg1: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg1, %arg0 [0, 6, 2, 3, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %0, %arg0 [0, 6, 7, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @sel_common_op_commute3_poison_mask_elts(%arg0: vector<5xi4>, %arg1: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg1, %arg0 [0, 6, 2, -1, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %0, %arg0 [0, 6, -1, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @sel_not_common_op_commute3(%arg0: vector<5xi4>, %arg1: vector<5xi4>, %arg2: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg1, %arg2 [0, 6, 2, 3, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %0, %arg0 [0, 6, 7, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @not_sel_common_op(%arg0: vector<5xi4>, %arg1: vector<5xi4>) -> vector<5xi4> {
    %0 = llvm.shufflevector %arg1, %arg0 [0, 6, 2, 3, 9] : vector<5xi4> 
    %1 = llvm.shufflevector %0, %arg0 [1, 6, 7, 3, 4] : vector<5xi4> 
    llvm.return %1 : vector<5xi4>
  }
  llvm.func @sel_common_op_extra_use(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.shufflevector %arg1, %arg0 [0, 5, 2, 7] : vector<4xi32> 
    llvm.call @use_v4i32(%0) : (vector<4xi32>) -> ()
    %1 = llvm.shufflevector %0, %arg0 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @identity_mask(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, -1, -1] : vector<4xf32> 
    %1 = llvm.shufflevector %0, %arg0 [0, -1, 6, 7] : vector<4xf32> 
    llvm.return %1 : vector<4xf32>
  }
}
