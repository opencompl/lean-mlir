module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32, ...)
  llvm.func @both_sides_fold_slt(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.select %arg1, %0, %arg0 : i1, i32
    %3 = llvm.select %arg1, %1, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @both_sides_fold_eq(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.select %arg1, %0, %arg0 : i1, i32
    %3 = llvm.select %arg1, %1, %arg0 : i1, i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @one_side_fold_slt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @one_side_fold_sgt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg2, %arg0 : i1, i32
    %1 = llvm.select %arg3, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @one_side_fold_eq(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @no_side_fold_cond(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg4, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "sle" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @no_side_fold_op(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg1 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @one_select_mult_use(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.addressof @use : !llvm.ptr
    %1 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %2 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @both_select_mult_use(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.addressof @use : !llvm.ptr
    %1 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %2 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    llvm.call %0(%1, %2) : !llvm.ptr, (i32, i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @fold_vector_ops(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>, %arg3: i1) -> vector<4xi1> {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, vector<4xi32>
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, vector<4xi32>
    %2 = llvm.icmp "eq" %1, %0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }
  llvm.func @fold_vector_cond_ops(%arg0: vector<8xi32>, %arg1: vector<8xi32>, %arg2: vector<8xi32>, %arg3: vector<8xi1>) -> vector<8xi1> {
    %0 = llvm.select %arg3, %arg0, %arg2 : vector<8xi1>, vector<8xi32>
    %1 = llvm.select %arg3, %arg1, %arg2 : vector<8xi1>, vector<8xi32>
    %2 = llvm.icmp "sgt" %1, %0 : vector<8xi32>
    llvm.return %2 : vector<8xi1>
  }
}
