import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.HSxComb.HSxCombFunctor
import SSA.Projects.CIRCT.Comb.Comb


namespace CIRCTStream

open MLIR AST in

instance : ToString DCOp.TokenStream where
  toString s := toString (Stream.toList 10 s)

instance : ToString (CIRCTStream.Stream (BitVec w))where
  toString s := toString (Stream.toList 10 s)

instance [ToString w] : ToString (Option w) where
  toString
    | some x => s!"(some {toString x})"
    | none   => "(none)"

instance [ToString w] : ToString (DCOp.ValueStream w) where
  toString s := toString (Stream.toList 10 s)

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals[i]?).join


/--
Initial handshake program:
handshake.func @add(%a : i32, %b : i32 ) -> i32{
  %add1 = comb.add %a, %a : i32
  %syncadd:2 = handshake.sync %add1, %b : i32, i32
  %add2 = comb.add %syncadd#1, %a : i32
  return %add2: i32
}
-/
def handshakeAdd := [HSxComb_com| {
  ^entry(%a: !Stream_BitVec_32, %b: !Stream_BitVec_32):
    %add1 = "HSxComb.add" (%a, %a) : (!Stream_BitVec_32, !Stream_BitVec_32) -> (!Stream_BitVec_32)
    %syncAdd = "HSxComb.sync" (%add1, %b) : (!Stream_BitVec_32, !Stream_BitVec_32) -> (!Stream2_BitVec_32)
    %syncAdd1 = "HSxComb.snd" (%syncAdd) : (!Stream2_BitVec_32) -> !Stream_BitVec_32
    %add2 = "HSxComb.add" (%syncAdd1, %a) : (!Stream_BitVec_32, !Stream_BitVec_32) -> (!Stream_BitVec_32)
    "return" (%add2) : (!Stream_BitVec_32) -> ()
  }]

#check handshakeAdd
#eval handshakeAdd
#reduce handshakeAdd
#check handshakeAdd.denote
#print axioms handshakeAdd

def a : Stream (BitVec 32) := ofList [1#32, none, 2#32, 5#32, none]
def b : Stream (BitVec 32) := ofList [none, 1#32, none, 2#32, 5#32]

def testHandshake : Stream (BitVec 32) :=
  handshakeAdd.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .nil))

#eval testHandshake


/--
Lowered DC program (13d1f6860):
module {
  hw.module @add(in %a : !dc.value<i32>, in %b : !dc.value<i32>, in %clk : !seq.clock {dc.clock}, in %rst : i1 {dc.reset}, out out0 : !dc.value<i32>) {
    %token, %output = dc.unpack %a : !dc.value<i32>
    %token_0, %output_1 = dc.unpack %a : !dc.value<i32>
    %0 = dc.join %token, %token_0
    %1 = comb.add %output, %output_1 : i32
    %2 = dc.pack %0, %1 : i32
    %token_2, %output_3 = dc.unpack %2 : !dc.value<i32>
    %token_4, %output_5 = dc.unpack %b : !dc.value<i32>
    %3 = dc.join %token_2, %token_4
    %4 = dc.pack %3, %output_3 : i32
    %5 = dc.pack %3, %output_5 : i32
    %token_6, %output_7 = dc.unpack %5 : !dc.value<i32>
    %token_8, %output_9 = dc.unpack %a : !dc.value<i32>
    %6 = dc.join %token_6, %token_8
    %7 = comb.add %output_7, %output_9 : i32
    %8 = dc.pack %6, %7 : i32
    hw.output %8 : !dc.value<i32>
  }
}
-/
def dcAdd := [DCxComb_com| {
  ^entry(%a: !ValueStream_32, %b: !ValueStream_32):
    %unpacka = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    %output1 = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token0 = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    %0 = "DCxComb.join" (%token, %token0) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %1 = "DCxComb.add" (%output, %output1) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    -- opposite args order wrt. circt
    %2 = "DCxComb.pack" (%1, %0) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    %unpack2 = "DCxComb.unpack" (%2) : (!ValueStream_32) -> (!ValueTokenStream_32)
    %output3 = "DCxComb.fstVal" (%unpack2) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token2 = "DCxComb.sndVal" (%unpack2) : (!ValueTokenStream_32) -> (!TokenStream)
    %unpackb = "DCxComb.unpack" (%b) : (!ValueStream_32) -> (!ValueTokenStream_32)
    %output5 = "DCxComb.fstVal" (%unpackb) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token4 = "DCxComb.sndVal" (%unpackb) : (!ValueTokenStream_32) -> (!TokenStream)
    %3 = "DCxComb.join" (%token2, %token4) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %4 = "DCxComb.pack" (%output3, %3) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    %5 = "DCxComb.pack" (%output5, %3) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    %unpack5 = "DCxComb.unpack" (%5) : (!ValueStream_32) -> (!ValueTokenStream_32)
    %output7 = "DCxComb.fstVal" (%unpack5) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token6 = "DCxComb.sndVal" (%unpack5) : (!ValueTokenStream_32) -> (!TokenStream)
    %unpackabis = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    %output9 = "DCxComb.fstVal" (%unpackabis) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token8 = "DCxComb.sndVal" (%unpackabis) : (!ValueTokenStream_32) -> (!TokenStream)
    %6 = "DCxComb.join" (%token6, %token8) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %7 = "DCxComb.add" (%output7, %output9) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %8 = "DCxComb.pack" (%7, %6) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    "return" (%8) : (!ValueStream_32) -> ()
  }]

#check dcAdd
#eval dcAdd
#reduce dcAdd
#check dcAdd.denote
#print axioms dcAdd

def aVal : DCOp.ValueStream (BitVec 32) := ofList [some 1#32, none, some 2#32, some 5#32, none]
def bVal : DCOp.ValueStream (BitVec 32) := ofList [none, some 1#32, none, some 2#32, some 5#32]

def testDC : DCOp.ValueStream (BitVec 32)  :=
  dcAdd.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .nil))

#eval testHandshake


/--
After canonicalization and materialization
module {
  hw.module @add(in %a : !dc.value<i32>, in %b : !dc.value<i32>, in %clk : !seq.clock {dc.clock}, in %rst : i1 {dc.reset}, out out0 : !dc.value<i32>) {
    %false = hw.constant false
    %token, %output = dc.unpack %a : !dc.value<i32>
    %0:3 = dc.fork [3] %token
    %1 = comb.extract %output from 0 : (i32) -> i31
    %2 = comb.concat %1, %false : i31, i1
    %token_0, %output_1 = dc.unpack %b : !dc.value<i32>
    %3 = dc.join %0#0, %token_0, %0#2, %0#1
    %4 = comb.add %2, %output : i32
    %5 = dc.pack %3, %4 : i32
    hw.output %5 : !dc.value<i32>
  }
}
-/
def dcAdd2 := [DCxComb_com| {
  ^entry(%a: !ValueStream_32, %b: !ValueStream_32):
    %unpacka = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    -- %fork = "DCxComb.fork" (%token) : (!TokenStream) -> (!TokenStream2) keep this implicit
    %2 = "DCxComb.add" (%output, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %unpackb = "DCxComb.unpack" (%b) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output1 = "DCxComb.fstVal" (%unpackb) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token0 = "DCxComb.sndVal" (%unpackb) : (!ValueTokenStream_32) -> (!TokenStream)
    %3 = "DCxComb.join" (%token, %token0) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %4 = "DCxComb.add" (%2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %5 = "DCxComb.pack" (%4, %3) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    "return" (%5) : (!ValueStream_32) -> ()
}]
#check dcAdd2
#eval dcAdd2
#reduce dcAdd2
#check dcAdd2.denote
#print axioms dcAdd2
-- delay-insensitive, hence easier to prove.




def dcAdd4 := [DCxComb_com| {
  ^entry(%a: !ValueStream_32, %b: !ValueStream_32):
    %unpacka = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    -- %fork = "DCxComb.fork" (%token) : (!TokenStream) -> (!TokenStream2) keep this implicit
    %2 = "DCxComb.add" (%output, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %b2 = "DCxComb.add" (%2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    -- %c2 = "DCxComb.add" (%b2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %unpackb = "DCxComb.unpack" (%b) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output1 = "DCxComb.fstVal" (%unpackb) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token0 = "DCxComb.sndVal" (%unpackb) : (!ValueTokenStream_32) -> (!TokenStream)
    %3 = "DCxComb.join" (%token, %token0) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %4 = "DCxComb.add" (%b2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %5 = "DCxComb.pack" (%4, %3) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    "return" (%5) : (!ValueStream_32) -> ()
}]
#check dcAdd2
#eval dcAdd2
#reduce dcAdd2
#check dcAdd2.denote
#print axioms dcAdd2
-- delay-insensitive, hence easier to prove/reason about.


def dcShl := [DCxComb_com| {
  ^entry(%a: !ValueStream_32, %b: !ValueStream_32):
    %unpacka = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    -- %fork = "DCxComb.fork" (%token) : (!TokenStream) -> (!TokenStream2) keep this implicit
    %2 = "DCxComb.shlPar_1" (%output) : (!ValueStream_32) -> (!ValueStream_32)
    %unpackb = "DCxComb.unpack" (%b) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output1 = "DCxComb.fstVal" (%unpackb) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token0 = "DCxComb.sndVal" (%unpackb) : (!ValueTokenStream_32) -> (!TokenStream)
    %3 = "DCxComb.join" (%token, %token0) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %4 = "DCxComb.add" (%2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %5 = "DCxComb.pack" (%4, %3) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    "return" (%5) : (!ValueStream_32) -> ()
}]

def testDCAdd2 : DCOp.ValueStream (BitVec 32)  :=
  dcAdd2.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .nil))

def testDCShl2 : DCOp.ValueStream (BitVec 32)  :=
  dcShl.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .nil))

#eval testDCAdd2
#eval testDCShl2

theorem equiv_add_shl (a : DCOp.ValueStream (BitVec 32)) :
    (dcAdd2.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons a <| .nil))) = (dcShl.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons a <| .nil))) := by
  unfold dcAdd2 dcShl
  simp_peephole

  sorry

theorem equiv_add (a : (BitVec 32)) :
    (CombOp.add [a, a]) = CombOp.shlPar a 1 := by
  simp [CombOp.add, CombOp.shlPar]
  bv_decide

-- theorem equiv_add_dcxcomb (a : DCOp.ValueStream (BitVec 32)) :
--     ((DCxCombFunctor.Op.comb add).denote (Ctxt.Valuation.ofHVector (.cons a <| .cons a <| .nil)))
--     ((DCxCombFunctor.Op.comb shlPar 2).denote (Ctxt.Valuation.ofHVector (.cons a <| .nil))) := by sorry
#check dcAdd'
#eval dcAdd'
#reduce dcAdd'
#check dcAdd'.denote
#print axioms dcAdd'
-- delay-insensitive, hence easier to prove/reason about.


def dcShl := [DCxComb_com| {
  ^entry(%a: !ValueStream_32, %b: !ValueStream_32):
    %unpacka = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    -- %fork = "DCxComb.fork" (%token) : (!TokenStream) -> (!TokenStream2) keep this implicit
    %2 = "DCxComb.shlPar_1" (%output) : (!ValueStream_32) -> (!ValueStream_32)
    %unpackb = "DCxComb.unpack" (%b) : (!ValueStream_32) -> (!ValueTokenStream_32)
    -- opposit args order wrt. circt
    %output1 = "DCxComb.fstVal" (%unpackb) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token0 = "DCxComb.sndVal" (%unpackb) : (!ValueTokenStream_32) -> (!TokenStream)
    %3 = "DCxComb.join" (%token, %token0) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %4 = "DCxComb.add" (%2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    %5 = "DCxComb.pack" (%4, %3) : (!ValueStream_32, !TokenStream) -> (!ValueStream_32)
    "return" (%5) : (!ValueStream_32) -> ()
}]

def testDCAdd2 : DCOp.ValueStream (BitVec 32)  :=
  dcAdd2.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .nil))

def testDCShl2 : DCOp.ValueStream (BitVec 32)  :=
  dcShl.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .nil))

#eval testDCAdd2
#eval testDCShl2

theorem equiv_add_shl (a : DCOp.ValueStream (BitVec 32)) :
    (dcAdd2.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons a <| .nil))) = (dcShl.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons a <| .nil))) := by
  simp [dcAdd2, dcShl]

  sorry

theorem equiv_add (a : (BitVec 32)) :
    (CombOp.add [a, a]) = CombOp.shlPar a 1 := by
  simp [CombOp.add, CombOp.shlPar]
  bv_decide

-- theorem equiv_add_dcxcomb (a : DCOp.ValueStream (BitVec 32)) :
--     ((DCxCombFunctor.Op.comb add).denote (Ctxt.Valuation.ofHVector (.cons a <| .cons a <| .nil)))
--     ((DCxCombFunctor.Op.comb shlPar 2).denote (Ctxt.Valuation.ofHVector (.cons a <| .nil))) := by sorry

-- theorem dc_eq (a b: DCOp.ValueStream (BitVec 32)) :
--   (dcAdd4.denote (Valuation.ofHVector (.cons a <| .cons b <| .nil))) = DCxComb.shiftLeft a >> 2 := by sorry
--   /--
--     1. rewrite comb add -> comb shl
--     2. generalized rewrite
--   -/
