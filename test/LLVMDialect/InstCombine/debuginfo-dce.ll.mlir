#di_file = #llvm.di_file<"test.c" in "/">
#di_null_type = #llvm.di_null_type
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 5.0.0 (trunk 297628) (llvm/trunk 297643)", isOptimized = true, emissionKind = Full>
#di_composite_type = #llvm.di_composite_type<tag = DW_TAG_structure_type, name = "entry", file = #di_file, line = 1, sizeInBits = 64>
#di_derived_type = #llvm.di_derived_type<tag = DW_TAG_pointer_type, baseType = #di_composite_type, sizeInBits = 64>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type, #di_derived_type, #di_derived_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "scan", file = #di_file, line = 4, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_subprogram1 = #llvm.di_subprogram<id = distinct[2]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "scan", file = #di_file, line = 4, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_subprogram2 = #llvm.di_subprogram<id = distinct[3]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "scan", file = #di_file, line = 4, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_subprogram3 = #llvm.di_subprogram<id = distinct[4]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "scan", file = #di_file, line = 4, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_subprogram4 = #llvm.di_subprogram<id = distinct[5]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "scan", file = #di_file, line = 4, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "entry", file = #di_file, line = 6, type = #di_derived_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram1, name = "entry", file = #di_file, line = 6, type = #di_derived_type>
#di_local_variable2 = #llvm.di_local_variable<scope = #di_subprogram2, name = "entry", file = #di_file, line = 6, type = #di_derived_type>
#di_local_variable3 = #llvm.di_local_variable<scope = #di_subprogram3, name = "entry", file = #di_file, line = 6, type = #di_derived_type>
#di_local_variable4 = #llvm.di_local_variable<scope = #di_subprogram4, name = "entry", file = #di_file, line = 6, type = #di_derived_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func local_unnamed_addr @salvage_load(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.intr.dbg.value #di_local_variable #llvm.di_expression<[DW_OP_plus_uconst(0)]> = %3 : !llvm.ptr
    llvm.store %3, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func local_unnamed_addr @salvage_bitcast(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    llvm.intr.dbg.value #di_local_variable1 #llvm.di_expression<[DW_OP_plus_uconst(0)]> = %arg0 : !llvm.ptr
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func local_unnamed_addr @salvage_gep0(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.entry", (ptr)>
    %5 = llvm.getelementptr inbounds %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.entry", (ptr)>
    llvm.intr.dbg.value #di_local_variable2 #llvm.di_expression<[DW_OP_plus_uconst(0)]> = %5 : !llvm.ptr
    llvm.store %5, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func local_unnamed_addr @salvage_gep1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.entry", (ptr)>
    %5 = llvm.getelementptr inbounds %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.entry", (ptr)>
    llvm.intr.dbg.value #di_local_variable3 #llvm.di_expression<[DW_OP_LLVM_fragment(0, 32)]> = %5 : !llvm.ptr
    llvm.store %5, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func local_unnamed_addr @salvage_gep2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.entry", (ptr)>
    %5 = llvm.getelementptr inbounds %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.entry", (ptr)>
    llvm.intr.dbg.value #di_local_variable4 #llvm.di_expression<[DW_OP_stack_value]> = %5 : !llvm.ptr
    llvm.store %5, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
}
