module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @add_shl_same_amount(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.add %0, %1  : i6
    llvm.return %2 : i6
  }
  llvm.func @add_shl_same_amount_nsw(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : vector<2xi4>
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : vector<2xi4>
    %2 = llvm.add %0, %1 overflow<nsw>  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @add_shl_same_amount_nuw(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i64
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i64
    %2 = llvm.add %0, %1 overflow<nuw>  : i64
    llvm.return %2 : i64
  }
  llvm.func @add_shl_same_amount_nsw_extra_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.add %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @add_shl_same_amount_nuw_extra_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @add_shl_same_amount_nsw_nuw_extra_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @add_shl_same_amount_partial_nsw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.add %0, %1  : i6
    llvm.return %2 : i6
  }
  llvm.func @add_shl_same_amount_partial_nsw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.add %0, %1 overflow<nsw>  : i6
    llvm.return %2 : i6
  }
  llvm.func @add_shl_same_amount_partial_nuw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i6
    %2 = llvm.add %0, %1  : i6
    llvm.return %2 : i6
  }
  llvm.func @add_shl_same_amount_partial_nuw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.add %0, %1 overflow<nuw>  : i6
    llvm.return %2 : i6
  }
  llvm.func @sub_shl_same_amount(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.sub %0, %1  : i6
    llvm.return %2 : i6
  }
  llvm.func @sub_shl_same_amount_nsw(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : vector<2xi4>
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : vector<2xi4>
    %2 = llvm.sub %0, %1 overflow<nsw>  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @sub_shl_same_amount_nuw(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i64
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i64
    %2 = llvm.sub %0, %1 overflow<nuw>  : i64
    llvm.return %2 : i64
  }
  llvm.func @sub_shl_same_amount_nsw_extra_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sub %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_shl_same_amount_nuw_extra_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_shl_same_amount_nsw_nuw_extra_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_shl_same_amount_partial_nsw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.sub %0, %1  : i6
    llvm.return %2 : i6
  }
  llvm.func @sub_shl_same_amount_partial_nsw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.sub %0, %1 overflow<nsw>  : i6
    llvm.return %2 : i6
  }
  llvm.func @sub_shl_same_amount_partial_nuw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i6
    %2 = llvm.sub %0, %1  : i6
    llvm.return %2 : i6
  }
  llvm.func @sub_shl_same_amount_partial_nuw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.sub %0, %1 overflow<nuw>  : i6
    llvm.return %2 : i6
  }
}
