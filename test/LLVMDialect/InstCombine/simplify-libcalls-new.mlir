module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @new() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%1) : (!llvm.ptr) -> ()
    %2 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_align() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_align_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%1) : (!llvm.ptr) -> ()
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_align() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamSt11align_val_t(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamRKSt9nothrow_t(%1, %2) : (i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_align_nothrow() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t(%1, %2, %3) : (i64, i64, !llvm.ptr) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_Znwm12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_align_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @new_align_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    %7 = llvm.call @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%7) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_Znam12__hot_cold_t(%0, %1) : (i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_align_hot_cold() {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%3) : (!llvm.ptr) -> ()
    %4 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamSt11align_val_t12__hot_cold_t(%0, %1, %2) : (i64, i64, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%4) : (!llvm.ptr) -> ()
    %5 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamRKSt9nothrow_t12__hot_cold_t(%1, %3, %2) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @array_new_align_nothrow_hot_cold() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%5) : (!llvm.ptr) -> ()
    %6 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%6) : (!llvm.ptr) -> ()
    %7 = llvm.call @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(%1, %2, %4, %3) : (i64, i64, !llvm.ptr, i8) -> !llvm.ptr
    llvm.call @dummy(%7) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @dummy(!llvm.ptr)
  llvm.func @_Znwm(i64) -> !llvm.ptr
  llvm.func @_ZnwmSt11align_val_t(i64, i64) -> !llvm.ptr
  llvm.func @_ZnwmRKSt9nothrow_t(i64, !llvm.ptr) -> !llvm.ptr
  llvm.func @_ZnwmSt11align_val_tRKSt9nothrow_t(i64, i64, !llvm.ptr) -> !llvm.ptr
  llvm.func @_Znam(i64) -> !llvm.ptr
  llvm.func @_ZnamSt11align_val_t(i64, i64) -> !llvm.ptr
  llvm.func @_ZnamRKSt9nothrow_t(i64, !llvm.ptr) -> !llvm.ptr
  llvm.func @_ZnamSt11align_val_tRKSt9nothrow_t(i64, i64, !llvm.ptr) -> !llvm.ptr
  llvm.func @_Znwm12__hot_cold_t(i64, i8) -> !llvm.ptr
  llvm.func @_ZnwmSt11align_val_t12__hot_cold_t(i64, i64, i8) -> !llvm.ptr
  llvm.func @_ZnwmRKSt9nothrow_t12__hot_cold_t(i64, !llvm.ptr, i8) -> !llvm.ptr
  llvm.func @_ZnwmSt11align_val_tRKSt9nothrow_t12__hot_cold_t(i64, i64, !llvm.ptr, i8) -> !llvm.ptr
  llvm.func @_Znam12__hot_cold_t(i64, i8) -> !llvm.ptr
  llvm.func @_ZnamSt11align_val_t12__hot_cold_t(i64, i64, i8) -> !llvm.ptr
  llvm.func @_ZnamRKSt9nothrow_t12__hot_cold_t(i64, !llvm.ptr, i8) -> !llvm.ptr
  llvm.func @_ZnamSt11align_val_tRKSt9nothrow_t12__hot_cold_t(i64, i64, !llvm.ptr, i8) -> !llvm.ptr
}
