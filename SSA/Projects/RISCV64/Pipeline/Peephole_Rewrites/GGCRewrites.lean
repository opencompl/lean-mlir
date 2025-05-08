import SSA.Projects.RISCV64.Pipeline.LLVMAndRiscv

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM)
/--
# Peephole Optimizations
This file contains Peephole Rewrites insipred by the rewrites LLVM performs.
This collection of rewrites will be used as patterns within the Risc-V peephole optimizartion pass.
Additionally they are insipred by the LLVM rewrites. -/

/-
the peephole optimization wrapper defined in the lean-mlir project.
  def RiscVToLLVMPeepholeRewriteRefine.toPeepholeUNSOUND (self : RiscVPeepholeRewriteRefine Γ) : PeepholeRewrite LLVMPlusRiscV Γ (Ty.riscv (.bv)) :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }

rewrite machinery:
  def rewritePeephole_go_multi (fuel : ℕ) (prs : List (PeepholeRewrite d Γ t))
    (ix : ℕ) (target : Com d Γ₂ eff t₂) : Com d Γ₂ eff t₂ :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
    let target' := prs.foldl (fun acc pr => rewritePeepholeAt pr ix acc) target
    rewritePeephole_go_multi fuel' prs (ix + 1) target'

def rewritePeephole_multi (fuel : ℕ)
   (prs : List (PeepholeRewrite d Γ t)) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
    rewritePeephole_go_multi fuel prs 0 target

-/

def peep_00_r:=
      [LV|{
      ^bb0(%X : i64):
      %1 = llvm.add %X, %X : i64
      %2 = llvm.sub %X, %X : i64
      %3 = llvm.add %1, %2 : i64
      llvm.return %3 : i64
  }]
def peep_00_l:=
      [LV|{
      ^bb0(%X : i64):
      %1 = llvm.add %X, %X : i64
      llvm.return %1 : i64
  }]

def peep0  : PeepholeRewrite LLVMPlusRiscV [.llvm (.bitvec 64)] (.llvm (.bitvec 64)) :=
  {lhs :=  peep_00_r , rhs := peep_00_l ,
    correct :=  by
      unfold peep_00_r peep_00_l
      simp_peephole
      sorry
  }

def test_peep0 :=  rewritePeephole_multi (10)  (peep_00_r) (peep0)

/-
optimization found in the gcc backend

LINE 222
/* Optimize (X + (X >> (prec - 1))) ^ (X >> (prec - 1)) into abs (X).  */
(simplify
 (bit_xor:c (plus:c @0 (rshift@2 @0 INTEGER_CST@1)) @2)
 (if (ANY_INTEGRAL_TYPE_P (TREE_TYPE (@0))
      && !TYPE_UNSIGNED (TREE_TYPE (@0))
      && wi::to_widest (@1) == element_precision (TREE_TYPE (@0)) - 1)
  (abs @0)))
#endif

/* See if ARG1 is zero and X + ARG1 reduces to X.
   Likewise if the operands are reversed.  */
(simplify
 (plus:c @0 real_zerop@1)
 (if (fold_real_zero_addition_p (type, @0, @1, 0))
  (non_lvalue @0)))


/* See if ARG1 is zero and X - ARG1 reduces to X.  */
(simplify
 (minus @0 real_zerop@1)
 (if (fold_real_zero_addition_p (type, @0, @1, 1))
  (non_lvalue @0)))


(simplify
 (mult @0 integer_zerop@1)
 @1)


#if GIMPLE
/* When multiplying a value by a boolean involving the value, we may
   be able to simplify further.
     a * ((a || b) != 0) -> a
     a * ((a || b) == 0) -> 0

   There are also bit-and cases which don't show up in practice yet.
     a * ((a && b) != 0) -> a * b
     a * ((a && b) == 0) -> b != 0 ? a : b */
(for neeq (ne eq)
 (simplify
  (mult:c (convert? (neeq (bit_ior:c @0 @1) integer_zerop@2)) @0)
  (if (neeq == EQ_EXPR)
   { build_zero_cst (type); }
   @0)))
#endif

/* Maybe fold x * 0 to 0.  The expressions aren't the same
   when x is NaN, since x * 0 is also NaN.  Nor are they the
   same in modes with signed zeros, since multiplying a
   negative value by 0 gives -0, not +0.  Nor when x is +-Inf,
   since x * 0 is NaN.  */
(simplify
 (mult @0 real_zerop@1)
 (if (!tree_expr_maybe_nan_p (@0)
      && (!HONOR_NANS (type) || !tree_expr_maybe_infinite_p (@0))
      && (!HONOR_SIGNED_ZEROS (type) || tree_expr_nonnegative_p (@0)))
  @1))

/* Transform x * -1.0 into -x.  */
(simplify
 (mult @0 real_minus_onep)
  (if (!tree_expr_maybe_signaling_nan_p (@0)
       && (!HONOR_SIGNED_ZEROS (type)
           || !COMPLEX_FLOAT_TYPE_P (type)))
   (negate @0)))

/* Transform x * { 0 or 1, 0 or 1, ... } into x & { 0 or -1, 0 or -1, ...},
   unless the target has native support for the former but not the latter.  */
(simplify
 (mult @0 VECTOR_CST@1)
 (if (initializer_each_zero_or_onep (@1)
      && !HONOR_SNANS (type)
      && !HONOR_SIGNED_ZEROS (type))
  (with { tree itype = FLOAT_TYPE_P (type) ? unsigned_type_for (type) : type; }
   (if (itype
	&& (!VECTOR_MODE_P (TYPE_MODE (type))
	    || (VECTOR_MODE_P (TYPE_MODE (itype))
		&& optab_handler (and_optab,
				  TYPE_MODE (itype)) != CODE_FOR_nothing)))
    (view_convert (bit_and:itype (view_convert @0)
				 (ne @1 { build_zero_cst (type); })))))))

/* X * 1, X / 1 -> X.  */
(for op (mult trunc_div ceil_div floor_div round_div exact_div)
  (simplify
    (op @0 integer_onep)
    (non_lvalue @0)))


/* Canonicalize x / (C1 * y) to (x * C2) / y.  */
 (simplify
  (rdiv @0 (mult:s @1 REAL_CST@2))
  (with
   { tree tem = const_binop (RDIV_EXPR, type, build_one_cst (type), @2); }
   (if (tem)
    (rdiv (mult @0 { tem; } ) @1))))

 /* Convert A/(B/C) to (A/B)*C  */
 (simplify
  (rdiv @0 (rdiv:s @1 @2))
   (mult (rdiv @0 @1) @2)))


  /* Simplify x / (- y) to -x / y.  */
(simplify
 (rdiv @0 (negate @1))
 (rdiv (negate @0) @1))


(for mod (ceil_mod floor_mod round_mod trunc_mod)
 /* 0 % X is always zero.  */
 (simplify
  (mod integer_zerop@0 @1)
  /* But not for 0 % 0 so that we can get the proper warnings and errors.  */
  (if (!integer_zerop (@1))
   @0))
 /* X % 1 is always zero.  */
 (simplify
  (mod @0 integer_onep)
  { build_zero_cst (type); })
 /* X % -1 is zero.  */
 (simplify
  (mod @0 integer_minus_onep@1)
  (if (!TYPE_UNSIGNED (type))
   { build_zero_cst (type); }))
 /* X % X is zero.  */
 (simplify
  (mod @0 @0)
  /* But not for 0 % 0 so that we can get the proper warnings and errors.  */
  (if (!integer_zerop (@0))
   { build_zero_cst (type); }))
 /* (X % Y) % Y is just X % Y.  */
 (simplify
  (mod (mod@2 @0 @1) @1)
  @2)
 /* From extract_muldiv_1: (X * C1) % C2 is zero if C1 is a multiple of C2.  */
 (simplify
  (mod (mult @0 INTEGER_CST@1) INTEGER_CST@2)
  (if (ANY_INTEGRAL_TYPE_P (type)
       && TYPE_OVERFLOW_UNDEFINED (type)
       && wi::multiple_of_p (wi::to_wide (@1), wi::to_wide (@2),
			     TYPE_SIGN (type)))
   { build_zero_cst (type); }))
 /* For (X % C) == 0, if X is signed and C is power of 2, use unsigned
    modulo and comparison, since it is simpler and equivalent.  */
 (for cmp (eq ne)
  (simplify
   (cmp (mod @0 integer_pow2p@2) integer_zerop@1)
   (if (!TYPE_UNSIGNED (TREE_TYPE (@0)))
    (with { tree utype = unsigned_type_for (TREE_TYPE (@0)); }
     (cmp (mod (convert:utype @0) (convert:utype @2)) (convert:utype @1)))))))

/* X % -C is the same as X % C.  */
(simplify
 (trunc_mod @0 INTEGER_CST@1)
  (if (TYPE_SIGN (type) == SIGNED
       && !TREE_OVERFLOW (@1)
       && wi::neg_p (wi::to_wide (@1))
       && !TYPE_OVERFLOW_TRAPS (type)
       /* Avoid this transformation if C is INT_MIN, i.e. C == -C.  */
       && !sign_bit_p (@1, @1))
   (trunc_mod @0 (negate @1))))




/* X - (X / Y) * Y is the same as X % Y.  */
(simplify
 (minus (convert1? @0) (convert2? (mult:c (trunc_div @@0 @@1) @1)))
 (if (INTEGRAL_TYPE_P (type)
      || (VECTOR_INTEGER_TYPE_P (type)
	  && ((optimize_vectors_before_lowering_p ()
	       && TREE_CODE (TYPE_SIZE (type)) == INTEGER_CST)
	      || target_supports_op_p (type, TRUNC_MOD_EXPR,
				       optab_vector))))
  (convert (trunc_mod @0 @1))))

/* x * (1 + y / x) - y -> x - y % x */
(simplify
 (minus (mult:cs @0 (plus:s (trunc_div:s @1 @0) integer_onep)) @1)
 (if (INTEGRAL_TYPE_P (type))
  (minus @0 (trunc_mod @1 @0))))


/* Shifts by constants distribute over several binary operations,
   hence (X << C) + (Y << C) can be simplified to (X + Y) << C.  */
(for op (plus minus)
  (simplify
    (op (lshift:s @0 @1) (lshift:s @2 @1))
    (if (INTEGRAL_TYPE_P (type)
	 && TYPE_OVERFLOW_WRAPS (type)
	 && !TYPE_SATURATING (type))
      (lshift (op @0 @2) @1))))

/* Fold (C1/X)*C2 into (C1*C2)/X.  */
(simplify
 (mult (rdiv@3 REAL_CST@0 @1) REAL_CST@2)
  (if (flag_associative_math
       && single_use (@3))
   (with
    { tree tem = const_binop (MULT_EXPR, type, @0, @2); }
    (if (tem)
     (rdiv { tem; } @1)))))

/* Fold (A & ~B) - (A & B) into (A ^ B) - B.  */
(simplify
 (minus (bit_and:cs @0 (bit_not @1)) (bit_and:cs @0 @1))
  (minus (bit_xor @0 @1) @1))
(simplify
 (minus (bit_and:s @0 INTEGER_CST@2) (bit_and:s @0 INTEGER_CST@1))
 (if (~wi::to_wide (@2) == wi::to_wide (@1))
  (minus (bit_xor @0 @1) @1)))


/* (a & ~b) | (a ^ b)  -->  a ^ b  */
(simplify
 (bit_ior:c (bit_and:c @0 (bit_not @1)) (bit_xor:c@2 @0 @1))
 @2)

/* (a & ~b) ^ ~a  -->  ~(a & b)  */
(simplify
 (bit_xor:c (bit_and:cs @0 (bit_not @1)) (bit_not @0))
 (bit_not (bit_and @0 @1)))

/* (~a & b) ^ a  -->   (a | b)   */
(simplify
 (bit_xor:c (bit_and:cs (bit_not @0) @1) @0)
 (bit_ior @0 @1))

/* (a | b) & ~(a ^ b)  -->  a & b  */
(simplify
 (bit_and:c (bit_ior @0 @1) (bit_not (bit_xor:c @0 @1)))
 (bit_and @0 @1))

1467

-/

/-
(simplify
 (mult @0 integer_zerop@1)
 @1)
-/

-- rhs refines the lefthandside
def match01 : PeepholeRewrite RV64 [.bv] .bv :=
{ lhs := [RV64_com| {
  ^bb0 (%X: !i64) :
  %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
  %0 = "RV64.mul" (%X,%1): (!i64,!i64 ) -> (!i64)
  "return" (%1) : ( !i64) -> ()
}],
  rhs := [RV64_com| {
    ^bb0 (%0: !i64) :
    %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    "return" (%1) : (!i64) -> ()
  }], correct := by
    simp_peephole
    bv_decide
}

def match02 : PeepholeRewrite RV64 [.bv] .bv :=
{ lhs := [RV64_com| {
  ^bb0 (%X: !i64) :
  %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
  %0 = "RV64.mul"(%1, %X): (!i64,!i64 ) -> (!i64)
  "return" (%1) : ( !i64) -> ()
}],
  rhs := [RV64_com| {
    ^bb0 (%0: !i64) :
    %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    "return" (%1) : (!i64) -> ()
  }], correct := by
    simp_peephole
    bv_decide

/-
/* (a | b) & ~(a ^ b)  -->  a & b  */
(simplify
 (bit_and:c (bit_ior @0 @1) (bit_not (bit_xor:c @0 @1)))
 (bit_and @0 @1))
-/
/-
def match03 : PeepholeRewrite RV64 [.bv] .bv :=
{ lhs := [RV64_com| {
  ^bb0 (%a: !i64, %b : !i64) :
  %1 = "RV64.or" (%a, %b): (!i64,!i64 ) -> (!i64)
  %2 = "RV64.xor" (%a, %b): (!i64,!i64 ) -> (!i64)
  %3 = "RV64.neg" (%2)  : ( !i64 ) -> (!i64)
  %4 = "RV64.and" (%1,%2)  : (!i64,!i64) -> (!i64)
  "return" (%4) : ( !i64) -> ()
}],-- negation not even defined on assembyl level
  rhs := [RV64_com| {
    ^bb0 (%0: !i64) :
    %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    "return" (%1) : (!i64) -> ()
  }], correct := by
    simp_peephole
    --bv_decide
-/
--

    -- show @Eq (BitVec _) _ _


 }
