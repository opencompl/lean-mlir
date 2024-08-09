module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i64)
  llvm.func @usei32(i32)
  llvm.func @usei1(i1)
  llvm.func @usub_sat_C1_C2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @usub_sat_C1_C2_produce_0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %2 = llvm.intr.usub.sat(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @usub_sat_C1_C2_produce_0_too(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @usub_sat_C1_C2_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @usub_sat_C1_C2_non_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[50, 64]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[20, 14]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @usub_sat_C1_C2_splat_produce_0(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %2 = llvm.intr.usub.sat(%1, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @usub_sat_C1_C2_splat_produce_0_too(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @usub_sat_C1_C2_non_splat_produce_0_too(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[12, 13]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[14, 15]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @usub_sat_C1_C2_without_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @max_sub_ugt(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @max_sub_uge(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @max_sub_uge_extrause1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.return %3 : i64
  }
  llvm.func @max_sub_uge_extrause2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }
  llvm.func @max_sub_uge_extrause3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }
  llvm.func @max_sub_ugt_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi32>
    %3 = llvm.sub %arg0, %arg1  : vector<4xi32>
    %4 = llvm.select %2, %3, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @max_sub_ult(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg1, %arg0 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.sub %arg1, %arg0  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }
  llvm.func @max_sub_ugt_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sub %arg1, %arg0  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }
  llvm.func @max_sub_ult_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ugt(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ult(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ugt_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }
  llvm.func @neg_max_sub_ult_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %arg1 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }
  llvm.func @max_sub_ugt_c1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ugt_c01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.select %2, %3, %0 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @max_sub_ugt_c10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ugt_c910(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ugt_c1110(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ugt_c0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @max_sub_ugt_cmiss(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c2_oneuseicmp(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.call @usei1(%3) : (i1) -> ()
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c2_oneusesub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.call @usei32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ugt_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %0, %arg0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_uge_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "uge" %0, %arg0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @max_sub_ult_c0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.select %2, %3, %0 : i1, i32
    llvm.return %4 : i32
  }
}
