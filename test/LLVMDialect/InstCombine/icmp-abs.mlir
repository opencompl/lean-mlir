module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @icmp_sge_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "sge" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_sge_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "sge" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_eq_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "eq" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_eq_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "eq" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ne_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "ne" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ne_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "ne" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_sle_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "sle" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_sle_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "sle" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_slt_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "slt" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_slt_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "slt" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_sgt_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "sgt" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_sgt_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "sgt" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ugt_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "ugt" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ugt_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "ugt" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_uge_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "uge" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_uge_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "uge" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ule_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "ule" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ule_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "ule" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ult_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "ult" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_ult_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4
    %1 = llvm.icmp "ult" %0, %arg0 : i4
    llvm.return %1 : i1
  }
  llvm.func @icmp_sge_abs2(%arg0: i4) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i4
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i4) -> i4
    %2 = llvm.icmp "sge" %0, %1 : i4
    llvm.return %2 : i1
  }
  llvm.func @icmp_sge_abs_mismatched_op(%arg0: i4, %arg1: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "sge" %0, %arg1 : i4
    llvm.return %1 : i1
  }
}
