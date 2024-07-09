#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "long long unsigned int", sizeInBits = 64, encoding = DW_ATE_unsigned>
#di_basic_type1 = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "unsigned int", sizeInBits = 32, encoding = DW_ATE_unsigned>
#di_file = #llvm.di_file<"test.i" in "/Data/radar/31209283">
#di_null_type = #llvm.di_null_type
#loc = loc("test.i":11:5)
#loc1 = loc("test.i":14:3)
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 6.0.0 (trunk 317434) (llvm/trunk 317437)", isOptimized = true, emissionKind = Full>
#di_derived_type = #llvm.di_derived_type<tag = DW_TAG_member, name = "p", baseType = #di_basic_type, sizeInBits = 64>
#di_derived_type1 = #llvm.di_derived_type<tag = DW_TAG_pointer_type, baseType = #di_basic_type, sizeInBits = 32>
#di_composite_type = #llvm.di_composite_type<tag = DW_TAG_structure_type, name = "v", file = #di_file, line = 2, sizeInBits = 64, elements = #di_derived_type>
#di_derived_type2 = #llvm.di_derived_type<tag = DW_TAG_pointer_type, baseType = #di_composite_type, sizeInBits = 32>
#di_derived_type3 = #llvm.di_derived_type<tag = DW_TAG_typedef, name = "v_t", baseType = #di_derived_type2>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type, #di_derived_type3, #di_derived_type1>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "f", file = #di_file, line = 6, scopeLine = 6, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_lexical_block = #llvm.di_lexical_block<scope = #di_subprogram, file = #di_file, line = 11, column = 5>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "start", file = #di_file, line = 6, arg = 2, type = #di_derived_type1>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "object", file = #di_file, line = 6, arg = 1, type = #di_derived_type3>
#di_local_variable2 = #llvm.di_local_variable<scope = #di_subprogram, name = "head_size", file = #di_file, line = 7, type = #di_basic_type1>
#di_local_variable3 = #llvm.di_local_variable<scope = #di_subprogram, name = "orig_start", file = #di_file, line = 8, type = #di_basic_type>
#di_local_variable4 = #llvm.di_local_variable<scope = #di_subprogram, name = "offset", file = #di_file, line = 9, type = #di_basic_type>
#loc2 = loc(fused<#di_lexical_block>[#loc])
#loc3 = loc(fused<#di_lexical_block>[#loc1])
#loop_annotation = #llvm.loop_annotation<startLoc = #loc2, endLoc = #loc3>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 32 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func local_unnamed_addr @f(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i1) attributes {passthrough = ["nounwind", "ssp"]} {
    llvm.intr.dbg.value #di_local_variable = %arg1 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %arg0 : !llvm.ptr
    %0 = llvm.mlir.constant(-4096 : i64) : i64
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.mlir.constant(-4096 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.undef : i32
    llvm.intr.dbg.value #di_local_variable2 = %5 : i32
    %6 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.intr.dbg.value #di_local_variable3 = %6 : i64
    %7 = llvm.add %6, %0  : i64
    llvm.intr.dbg.value #di_local_variable4 = %7 : i64
    llvm.cond_br %arg2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%7, %1 : i64, i32)
  ^bb2(%8: i64, %9: i32):  // 2 preds: ^bb1, ^bb2
    llvm.intr.dbg.value #di_local_variable2 = %9 : i32
    %10 = llvm.call %2(%8, %arg0) : !llvm.ptr, (i64, !llvm.ptr) -> i32
    %11 = llvm.add %9, %3  : i32
    llvm.intr.dbg.value #di_local_variable2 = %11 : i32
    %12 = llvm.add %8, %0  : i64
    llvm.intr.dbg.value #di_local_variable4 = %12 : i64
    %13 = llvm.icmp "eq" %11, %4 : i32
    llvm.cond_br %13, ^bb3, ^bb2(%12, %11 : i64, i32) {loop_annotation = #loop_annotation}
  ^bb3:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }
  llvm.func local_unnamed_addr @use(...) -> i32
}
