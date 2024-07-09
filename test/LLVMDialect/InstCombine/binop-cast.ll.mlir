module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @use_vec(vector<2xi32>)
  llvm.func @testAdd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }
  llvm.func @and_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @and_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @and_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @and_not_sext_to_sel(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @and_not_sext_to_sel_commute(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %2, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_not_zext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @or_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @or_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @or_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @or_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @xor_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @xor_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @xor_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @xor_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @PR63321(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.zext %1 : i8 to i64
    %3 = llvm.add %0, %2  : i64
    %4 = llvm.and %3, %arg1  : i64
    llvm.return %4 : i64
  }
  llvm.func @and_add_non_bool(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.zext %1 : i8 to i64
    %3 = llvm.add %0, %2  : i64
    %4 = llvm.and %3, %arg1  : i64
    llvm.return %4 : i64
  }
  llvm.func @and_add_bool_to_select(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_add_bool_no_fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_add_bool_vec_to_select(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.add %0, %1  : vector<2xi32>
    %3 = llvm.and %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @and_add_bool_to_select_multi_use(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
}
