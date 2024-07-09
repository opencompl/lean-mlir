module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i64
  llvm.func @abs(i32) -> i32
  llvm.func @labs(i64) -> i64
  llvm.func @llabs(i64) -> i64
  llvm.func @test_abs(%arg0: i32) -> i32 {
    %0 = llvm.call @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test_labs(%arg0: i64) -> i64 {
    %0 = llvm.call @labs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }
  llvm.func @test_llabs(%arg0: i64) -> i64 {
    %0 = llvm.call @llabs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }
  llvm.func @abs_canonical_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_canonical_2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %4 = llvm.sub %2, %arg0  : vector<2xi8>
    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @abs_canonical_2_vec_poison_elts(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "sgt" %arg0, %6 : vector<2xi8>
    %10 = llvm.sub %8, %arg0  : vector<2xi8>
    %11 = llvm.select %9, %arg0, %10 : vector<2xi1>, vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }
  llvm.func @abs_canonical_3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_canonical_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.sub %1, %arg0  : i8
    %4 = llvm.select %2, %3, %arg0 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @abs_canonical_5(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.select %2, %3, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @abs_canonical_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @abs_canonical_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    %3 = llvm.sub %arg1, %arg0  : vector<2xi8>
    %4 = llvm.select %2, %1, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @abs_canonical_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @abs_canonical_9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %1, %3 : i1, i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @abs_canonical_10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @nabs_canonical_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_canonical_2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %4 = llvm.sub %2, %arg0  : vector<2xi8>
    %5 = llvm.select %3, %4, %arg0 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @nabs_canonical_2_vec_poison_elts(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "sgt" %arg0, %6 : vector<2xi8>
    %10 = llvm.sub %8, %arg0  : vector<2xi8>
    %11 = llvm.select %9, %10, %arg0 : vector<2xi1>, vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }
  llvm.func @nabs_canonical_3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_canonical_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.sub %1, %arg0  : i8
    %4 = llvm.select %2, %arg0, %3 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @nabs_canonical_5(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.select %2, %4, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @nabs_canonical_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @nabs_canonical_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    %3 = llvm.sub %arg1, %arg0  : vector<2xi8>
    %4 = llvm.select %2, %3, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @nabs_canonical_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @nabs_canonical_9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @nabs_canonical_10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @shifty_abs_commute0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @shifty_abs_commute0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0 overflow<nsw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @shifty_abs_commute0_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @shifty_abs_commute1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.xor %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @shifty_abs_commute2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    %5 = llvm.xor %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @shifty_abs_commute3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    %4 = llvm.add %2, %3  : i8
    %5 = llvm.xor %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @extra_use(i8)
  llvm.func @extra_use_i1(i1)
  llvm.func @shifty_abs_too_many_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %arg0, %1  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.return %3 : i8
  }
  llvm.func @shifty_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.xor %arg0, %1  : i8
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @shifty_sub_nsw_commute(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.xor %1, %arg0  : i8
    %3 = llvm.sub %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @shifty_sub_nuw_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.ashr %arg0, %0  : vector<4xi32>
    %2 = llvm.xor %1, %arg0  : vector<4xi32>
    %3 = llvm.sub %2, %1 overflow<nuw>  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @shifty_sub_nsw_nuw(%arg0: i12) -> i12 {
    %0 = llvm.mlir.constant(11 : i12) : i12
    %1 = llvm.ashr %arg0, %0  : i12
    %2 = llvm.xor %arg0, %1  : i12
    %3 = llvm.sub %2, %1 overflow<nsw, nuw>  : i12
    llvm.return %3 : i12
  }
  llvm.func @negate_abs(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    %4 = llvm.sub %0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_nabs(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi8>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi8>
    %5 = llvm.sub %1, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @abs_must_be_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @abs_swapped(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_swapped(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_different_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg0, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @nabs_different_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %arg0 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @infinite_loop_constant_expression_abs(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %1, %arg0  : i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    %5 = llvm.sub %2, %3 overflow<nsw>  : i64
    %6 = llvm.select %4, %5, %3 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @abs_extra_use_icmp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_extra_use_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_extra_use_icmp_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_extra_use_icmp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_extra_use_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_extra_use_icmp_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_diff_signed_slt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @nabs_diff_signed_sle(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi8>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.select %0, %2, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @abs_diff_signed_sgt(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_sge(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_slt_no_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @abs_diff_signed_sgt_nsw_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_sgt_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_sgt_nuw_extra_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_sgt_nuw_extra_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_sgt_nuw_extra_use3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_slt_swap_wrong_pred1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @abs_diff_signed_slt_swap_wrong_pred2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @abs_diff_signed_slt_swap_wrong_op(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @abs_diff_signed_slt_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @abs_diff_signed_sle_swap(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi8>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.select %0, %1, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @nabs_diff_signed_sgt_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @nabs_diff_signed_sge_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @abs_diff_signed_slt_no_nsw_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }
}
