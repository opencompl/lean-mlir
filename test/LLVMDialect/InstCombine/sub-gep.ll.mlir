module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<16> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @Arr() {addr_space = 0 : i32} : !llvm.array<42 x i16>
  llvm.mlir.global external @Arr_as1() {addr_space = 1 : i32} : !llvm.array<42 x i16>
  llvm.func @test_inbounds(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_partial_inbounds1(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_partial_inbounds2(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_inbounds_nuw(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_nuw(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_inbounds_nuw_trunc(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.trunc %2 : i64 to i32
    %5 = llvm.trunc %3 : i64 to i32
    %6 = llvm.sub %5, %4 overflow<nuw>  : i32
    llvm.return %6 : i32
  }
  llvm.func @test_inbounds_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_inbounds1_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_inbounds2_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_inbounds_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %5 = llvm.sub %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @test_inbounds_nsw_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %5 = llvm.sub %4, %3 overflow<nsw>  : i64
    llvm.return %5 : i64
  }
  llvm.func @test_inbounds_nuw_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %5 = llvm.sub %4, %3 overflow<nuw>  : i64
    llvm.return %5 : i64
  }
  llvm.func @test_inbounds_nuw_multi_index(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1, %arg2] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<0 x array<2 x i32>>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }
  llvm.func @test23(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test23_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i8 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %2 = llvm.trunc %1 : i16 to i8
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i16
    %4 = llvm.trunc %3 : i16 to i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @test24(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @test24_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i16 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i16
    %3 = llvm.sub %1, %2  : i16
    llvm.return %3 : i16
  }
  llvm.func @test24a(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.sub %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @test24a_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i16 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i16
    %3 = llvm.sub %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @test24b(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @Arr : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %0[%1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<42 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.sub %4, %2  : i64
    llvm.return %5 : i64
  }
  llvm.func @test25(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @Arr : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.getelementptr inbounds %0[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<42 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.getelementptr inbounds %0[%1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<42 x i16>
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.sub %6, %4  : i64
    llvm.return %7 : i64
  }
  llvm.func @test25_as1(%arg0: !llvm.ptr<1>, %arg1: i64) -> i16 {
    %0 = llvm.mlir.addressof @Arr_as1 : !llvm.ptr<1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.getelementptr inbounds %0[%2, %1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<42 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i16
    %5 = llvm.getelementptr inbounds %0[%1, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<42 x i16>
    %6 = llvm.ptrtoint %5 : !llvm.ptr<1> to i16
    %7 = llvm.sub %6, %4  : i16
    llvm.return %7 : i16
  }
  llvm.func @test30(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test30_as1(%arg0: !llvm.ptr<1>, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %3 = llvm.ptrtoint %1 : !llvm.ptr<1> to i16
    %4 = llvm.sub %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @gep_diff_both_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @gep_diff_first_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @gep_diff_second_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @gep_diff_with_bitcast(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3 overflow<nuw>  : i64
    %5 = llvm.lshr %4, %0  : i64
    llvm.return %5 : i64
  }
  llvm.func @sub_scalable(%arg0: !llvm.ptr {llvm.noundef}) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @sub_scalable2(%arg0: !llvm.ptr {llvm.noundef}) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.sub %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @nullptrtoint_scalable_c() -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }
  llvm.func @nullptrtoint_scalable_x(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    llvm.return %2 : i64
  }
  llvm.func @_gep_phi1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb4(%1 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.cond_br %6, ^bb4(%1 : i64), ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%7: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.getelementptr inbounds %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8
    %10 = llvm.icmp "eq" %9, %2 : i8
    llvm.cond_br %10, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    %11 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %12 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %13 = llvm.sub %11, %12  : i64
    llvm.br ^bb4(%13 : i64)
  ^bb4(%14: i64):  // 3 preds: ^bb0, ^bb1, ^bb3
    %15 = llvm.icmp "ne" %14, %1 : i64
    llvm.return %15 : i1
  }
  llvm.func @_gep_phi2(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb4(%1 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.cond_br %6, ^bb4(%1 : i64), ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%7: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.getelementptr inbounds %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8
    %10 = llvm.icmp "eq" %9, %2 : i8
    llvm.cond_br %10, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    %11 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %12 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %13 = llvm.sub %11, %12  : i64
    llvm.br ^bb4(%13 : i64)
  ^bb4(%14: i64):  // 3 preds: ^bb0, ^bb1, ^bb3
    %15 = llvm.or %14, %arg1  : i64
    %16 = llvm.icmp "eq" %15, %1 : i64
    llvm.return %16 : i1
  }
}
