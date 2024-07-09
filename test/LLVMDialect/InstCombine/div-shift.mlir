module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @a() {addr_space = 0 : i32} : i32
  llvm.func @use(i8)
  llvm.func @use32(i32)
  llvm.func @t1(%arg0: i16 {llvm.zeroext}, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.sdiv %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @t1vec(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.shl %0, %arg1  : vector<2xi32>
    %3 = llvm.sdiv %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @t2(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.udiv %arg0, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @t3(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.udiv %arg0, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @t4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.udiv %arg0, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @t5(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(64 : i32) : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.select %arg0, %1, %2 : i1, i32
    %5 = llvm.select %arg1, %4, %3 : i1, i32
    %6 = llvm.udiv %arg2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @t6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.udiv %arg1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @udiv_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_umax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_umin_(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.intr.umin(%1, %arg2)  : (i8, i8) -> i8
    %3 = llvm.udiv %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @udiv_umin_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_smin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @t7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @t8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.sdiv %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @t9(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : vector<2xi32>
    %2 = llvm.sdiv %1, %arg0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @t10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @t11(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %1 = llvm.sdiv %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @t12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.udiv %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @t13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.udiv %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @t14(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi32>
    %2 = llvm.udiv %1, %arg0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @t15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.udiv %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @t16(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : vector<2xi32>
    %1 = llvm.udiv %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @sdiv_mul_shl_nsw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_mul_shl_nsw_exact_commute1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nsw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_mul_shl_nsw_commute2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nsw>  : i5
    %1 = llvm.shl %arg2, %arg0 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_mul_shl_nsw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_mul_shl_nsw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_mul_shl_nsw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_mul_nsw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg2, %arg0 overflow<nsw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_mul_shl_missing_nsw1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_mul_shl_missing_nsw2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_mul_shl_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_mul_shl_nuw_exact_commute1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_mul_shl_nuw_commute2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg2, %arg0 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_mul_shl_nsw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_mul_shl_nsw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_mul_shl_nsw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_mul_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_shl_mul_nuw_swap(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_shl_mul_nuw_exact(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_shl_mul_nuw_vec(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : vector<2xi4>
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : vector<2xi4>
    %2 = llvm.udiv %0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @udiv_shl_mul_nuw_extra_use_of_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_mul_nuw_extra_use_of_mul(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_mul_nuw_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_mul_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_mul_shl_missing_nsw1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_mul_shl_missing_nsw2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_shl_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @udiv_shl_nuw_exact(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : vector<2xi4>
    %1 = llvm.udiv %arg0, %0  : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }
  llvm.func @udiv_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @udiv_shl_nuw_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @udiv_lshr_mul_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_lshr_mul_nuw_exact_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : vector<2xi4>
    %1 = llvm.lshr %0, %arg2  : vector<2xi4>
    %2 = llvm.udiv %1, %arg0  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @udiv_lshr_mul_nuw_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    %1 = llvm.lshr %arg2, %0  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_lshr_mul_nuw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_lshr_mul_nuw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_lshr_mul_nuw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_lshr_mul_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_lshr_mul_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_shl_nsw2_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_shl_nsw2_nuw_exact_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_shl_nsw_nuw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_shl_nsw_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sdiv_shl_shl_nuw_nsw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_shl_nuw2(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : vector<2xi8>
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : vector<2xi8>
    %2 = llvm.udiv %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @udiv_shl_shl_nuw2_exact_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_shl_nuw_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_shl_nsw_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_shl_nuw_nsw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @udiv_shl_nuw_divisor(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @udiv_fail_shl_overflow(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_shl_no_overflow(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @sdiv_shl_pair_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.shl %arg0, %1 overflow<nsw>  : i32
    %4 = llvm.sdiv %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @udiv_shl_pair_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : i32
    %4 = llvm.udiv %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @sdiv_shl_pair1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_no_pair_fail(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg1, %arg3 overflow<nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_shl_pair1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_shl_pair2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_shl_pair3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair_overflow_fail1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair_overflow_fail2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_shl_pair_overflow_fail1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_shl_pair_overflow_fail2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_shl_pair_overflow_fail3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair_multiuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv_shl_pair_multiuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @pr69291() -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i32
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i32
    %4 = llvm.shl %2, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.sdiv %3, %4  : i32
    llvm.return %5 : i32
  }
}
