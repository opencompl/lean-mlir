module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @src_srem_shl_demand_max_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_demand_min_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_demand_max_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_demand_max_signbit_mask_hit_first_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(29 : i32) : i32
    %2 = llvm.mlir.constant(-1073741824 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_demand_min_signbit_mask_hit_last_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(536870912 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1073741822 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_demand_eliminate_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_demand_max_mask_hit_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @src_srem_shl_mask_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<29> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.shl %3, %1  : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @src_srem_shl_mask_vector_nonconstant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %2, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @sext_shl_trunc_same_size(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }
  llvm.func @sext_shl_trunc_smaller(%arg0: i16, %arg1: i32) -> i5 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i5
    llvm.return %2 : i5
  }
  llvm.func @sext_shl_trunc_larger(%arg0: i16, %arg1: i32) -> i17 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i17
    llvm.return %2 : i17
  }
  llvm.func @sext_shl_mask(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.shl %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @sext_shl_mask_higher(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.shl %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @set_shl_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(196609 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @must_drop_poison(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.shl %1, %arg1 overflow<nsw, nuw>  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @f_t15_t01_t09(%arg0: i40) -> i32 {
    %0 = llvm.mlir.constant(31 : i40) : i40
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i40
    %4 = llvm.trunc %3 : i40 to i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.ashr %5, %1  : i32
    %7 = llvm.shl %6, %2  : i32
    llvm.return %5 : i32
  }
}
