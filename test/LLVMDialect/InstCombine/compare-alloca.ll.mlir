module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @gp() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @alloca_argument_compare(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @alloca_argument_compare_swapped(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @alloca_argument_compare_ne(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @alloca_argument_compare_derived_ptrs(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i64) -> !llvm.ptr
    %3 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %4 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @escape(!llvm.ptr)
  llvm.func @alloca_argument_compare_escaped_alloca(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @escape(%1) : (!llvm.ptr) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @check_compares(i1, i1)
  llvm.func @alloca_argument_compare_two_compares(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %6 = llvm.icmp "eq" %arg0, %3 : !llvm.ptr
    %7 = llvm.icmp "eq" %4, %5 : !llvm.ptr
    llvm.call @check_compares(%6, %7) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @alloca_argument_compare_escaped_through_store(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %arg0 : !llvm.ptr
    %4 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %4, %arg1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @alloca_argument_compare_benign_instrs(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %3, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @allocator() -> !llvm.ptr
  llvm.func @alloca_call_compare() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.call @allocator() : () -> !llvm.ptr
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @hidden_inttoptr() -> !llvm.ptr
  llvm.func @hidden_offset(!llvm.ptr) -> !llvm.ptr
  llvm.func @ptrtoint_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @offset_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @witness(i1, i1)
  llvm.func @consistent_fold1() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %5 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @consistent_fold2() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.call @hidden_offset(%2) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %1, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @consistent_fold3() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @neg_consistent_fold4() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @unknown(!llvm.ptr)
  llvm.func @consistent_nocapture_inttoptr() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @consistent_nocapture_offset() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @unknown(%1) : (!llvm.ptr) -> ()
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @consistent_nocapture_through_global() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @unknown(%3) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @select_alloca_unrelated_ptr(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg1 : !llvm.ptr
    %3 = llvm.select %arg0, %1, %arg2 : i1, !llvm.ptr
    %4 = llvm.icmp "eq" %3, %arg1 : !llvm.ptr
    llvm.call @witness(%2, %4) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @alloca_offset_icmp(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<4 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    %4 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.call @witness(%3, %4) : (i1, i1) -> ()
    llvm.return
  }
}
