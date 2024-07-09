module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test_add_res_moreoneuse(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %1 : i32
  }
  llvm.func @test_addop_nonsw_flag(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test_add_op2_not_constant(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test_zext_nneg(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test_zext_missing_nneg(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @gep_inbounds_add_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @gep_inbounds_add_nsw_not_nonneg1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @gep_inbounds_add_nsw_not_nonneg2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @gep_not_inbounds_add_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @gep_inbounds_add_not_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %arg2  : i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @gep_inbounds_sext_add_nonneg(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @gep_inbounds_sext_add_not_nonneg_1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @gep_inbounds_sext_add_not_nonneg_2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @gep_not_inbounds_sext_add_nonneg(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }
}
