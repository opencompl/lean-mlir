import SSA.Core
import SSA.Projects.CIRCT.DCPlus.DCPlus
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

open CIRCTStream

open MLIR2DCPlus

/-! This file implements dataflow rewrites from https://dl.acm.org/doi/pdf/10.1145/3676641.3715993. -/

/-- rewrite (a) for the `T` output stream -/
def rewrite_a_T : PeepholeRewrite DCPlus [.valuestream 1, .tokenstream] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
        %branch = "DCPlus.branch" (%1, %0) : (!ValueStream_1, !TokenStream) -> (!TokenStream2)
        %fst = "DCPlus.fst" (%branch) :  (!TokenStream2) -> (!TokenStream)
        "return" (%fst) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
        %fork = "DCPlus.fork" (%0) : (!TokenStream) -> (!TokenStream2)
        %fst = "DCPlus.fst" (%fork) : (!TokenStream2) -> (!TokenStream)
        %forkVal = "DCPlus.forkVal" (%1) : (!ValueStream_1) -> (!ValueStream2_1)
        %fstValPure = "DCPlus.fstValPure" (%forkVal) : (!ValueStream2_1) -> (!ValueStream_1)
        %not = "DCPlus.not" (%fstValPure) : (!ValueStream_1) -> (!ValueStream_1)
        %supp = "DCPlus.supp" (%not, %fst) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        "return" (%supp) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }


/-- rewrite (a) for the `F` output stream -/
def rewrite_a_F : PeepholeRewrite DCPlus [.valuestream 1, .tokenstream] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
        %branch = "DCPlus.branch" (%1, %0) : (!ValueStream_1, !TokenStream) -> (!TokenStream2)
        %snd = "DCPlus.snd" (%branch) :  (!TokenStream2) -> (!TokenStream)
        "return" (%snd) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
        %fork = "DCPlus.fork" (%0) : (!TokenStream) -> (!TokenStream2)
        %snd = "DCPlus.snd" (%fork) : (!TokenStream2) -> (!TokenStream)
        %forkVal = "DCPlus.forkVal" (%1) : (!ValueStream_1) -> (!ValueStream2_1)
        %sndValPure = "DCPlus.sndValPure" (%forkVal) : (!ValueStream2_1) -> (!ValueStream_1)
        %supp = "DCPlus.supp" (%sndValPure, %snd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        "return" (%supp) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }

/- rewrite (b) is not feasible because of the feedback loop AFAIU -/

/-- rewrite (c) for the `A` output stream -/
def rewrite_c_A : PeepholeRewrite DCPlus [.tokenstream, .valuestream 1] [.valuestream 1] :=
  { lhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %forkc = "DCPlus.forkVal" (%c) : (!ValueStream_1) -> (!ValueStream2_1)
        %fstc = "DCPlus.fstValPure" (%forkc) : (!ValueStream2_1) -> (!ValueStream_1)
        %sndc = "DCPlus.sndValPure" (%forkc) : (!ValueStream2_1) -> (!ValueStream_1)
        %forkd = "DCPlus.fork" (%d) : (!TokenStream) -> (!TokenStream2)
        %fstd = "DCPlus.fst" (%forkd) : (!TokenStream2) -> (!TokenStream)
        %sndd = "DCPlus.snd" (%forkd) : (!TokenStream2) -> (!TokenStream)
        %supp1 = "DCPlus.supp" (%fstc, %fstd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %not = "DCPlus.not" (%sndc) : (!ValueStream_1) -> (!ValueStream2_1)
        %supp2 = "DCPlus.supp" (%not, %sndd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %cmerge = "DCPlus.cMerge" (%supp1, %supp2) : (!TokenStream, !TokenStream) -> (!ValueTokenStream_1)
        %fstmerge = "DCPlus.fstVal" (%cmerge) : (!ValueTokenStream_1) -> (!ValueStream_1)
        "return" (%fstmerge) : (!ValueStream_1) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        "return" (%c) : (!ValueStream_1) -> ()
      }],
    correct :=
    by sorry
    }

/-- rewrite (c) for the `B` output stream -/
def rewrite_c_B : PeepholeRewrite DCPlus [.tokenstream, .valuestream 1] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %forkc = "DCPlus.forkVal" (%c) : (!ValueStream_1) -> (!ValueStream2_1)
        %fstc = "DCPlus.fstValPure" (%forkc) : (!ValueStream2_1) -> (!ValueStream_1)
        %sndc = "DCPlus.sndValPure" (%forkc) : (!ValueStream2_1) -> (!ValueStream_1)
        %forkd = "DCPlus.fork" (%d) : (!TokenStream) -> (!TokenStream2)
        %fstd = "DCPlus.fst" (%forkd) : (!TokenStream2) -> (!TokenStream)
        %sndd = "DCPlus.snd" (%forkd) : (!TokenStream2) -> (!TokenStream)
        %supp1 = "DCPlus.supp" (%fstc, %fstd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %not = "DCPlus.not" (%sndc) : (!ValueStream_1) -> (!ValueStream2_1)
        %supp2 = "DCPlus.supp" (%not, %sndd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %cmerge = "DCPlus.cMerge" (%supp1, %supp2) : (!TokenStream, !TokenStream) -> (!ValueTokenStream_1)
        %sndmerge = "DCPlus.sndVal" (%cmerge) : (!ValueTokenStream_1) -> (!TokenStream)
        "return" (%sndmerge) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        "return" (%d) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }

/- rewrite (d) is not feasible because of the feedback loop AFAIU -/

/-- rewrite (e) -/
def rewrite_e : PeepholeRewrite DCPlus [.tokenstream, .valuestream 1] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %forkc = "DCPlus.forkVal" (%c) : (!ValueStream_1) -> (!ValueStream2_1)
        %forkc' = "DCPlus.forkVal" (%c) : (!ValueStream_1) -> (!ValueStream2_1)
        %fstc = "DCPlus.fstValPure" (%forkc) : (!ValueStream2_1) -> (!ValueStream_1)
        %sndc = "DCPlus.sndValPure" (%forkc) : (!ValueStream2_1) -> (!ValueStream_1)
        %trdc = "DCPlus.fstValPure" (%forkc') : (!ValueStream2_1) -> (!ValueStream_1)
        %forkd = "DCPlus.fork" (%d) : (!TokenStream) -> (!TokenStream2)
        %fstd = "DCPlus.fst" (%forkd) : (!TokenStream2) -> (!TokenStream)
        %sndd = "DCPlus.snd" (%forkd) : (!TokenStream2) -> (!TokenStream)
        %supp1 = "DCPlus.supp" (%fstc, %fstd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %not = "DCPlus.not" (%sndc) : (!ValueStream_1) -> (!ValueStream2_1)
        %supp2 = "DCPlus.supp" (%not, %sndd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %mux = "DCPlus.mux" (%supp1, %supp2, %trdc) : (!TokenStream, !TokenStream, !ValueStream_1) -> (!TokenStream)
        "return" (%mux) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        "return" (%d) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }


/- rewrite (f) is not feasible because of the feedback loop AFAIU -/

/-- rewrite (g) -/
def rewrite_g : PeepholeRewrite DCPlus [.tokenstream, .valuestream 1, .valuestream 1] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%m : !ValueStream_1, %n : !ValueStream_1, %d : !TokenStream):
        %supp1 = "DCPlus.supp" (%m, %d) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %supp2 = "DCPlus.supp" (%n, %supp1) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        "return" (%supp2) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%m : !ValueStream_1, %n : !ValueStream_1, %d : !TokenStream):
        %source1 = "DCPlus.sourceOnes" () : () -> (!ValueStream_1)
        %mux = "DCPlus.muxVal" (%n, %source1, %m) : (!ValueStream_1, !ValueStream_1, !ValueStream_1) -> (!ValueStream_1)
        %supp = "DCPlus.supp" (%mux, %d) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        "return" (%supp) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }

/-- rewrite (h) for `A` output stream -/
def rewrite_h_A : PeepholeRewrite DCPlus [.tokenstream, .valuestream 1] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %supp = "DCPlus.supp" (%c, %d) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %fork = "DCPlus.fork" (%supp) :  (!TokenStream) -> (!TokenStream2)
        %fst = "DCPlus.fst" (%fork) : (!TokenStream2) -> (!TokenStream)
        "return" (%fst) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %fork = "DCPlus.fork" (%d) : (!TokenStream) -> (!TokenStream2)
        %fst = "DCPlus.fst" (%fork) : (!TokenStream2) -> (!TokenStream)
        %forkVal = "DCPlus.forkVal" (%c) : (!ValueStream_1) -> (!ValueStream2_1)
        %fstValPure = "DCPlus.fstValPure" (%forkVal) : (!ValueStream2_1) -> (!ValueStream_1)
        %supp = "DCPlus.supp" (%fstValPure, %fst) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        "return" (%supp) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }

/-- rewrite (h) for `B` output stream -/
def rewrite_h_B : PeepholeRewrite DCPlus [.tokenstream, .valuestream 1] [.tokenstream] :=
  { lhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %supp = "DCPlus.supp" (%c, %d) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        %fork = "DCPlus.fork" (%supp) :  (!TokenStream) -> (!TokenStream2)
        %snd = "DCPlus.snd" (%fork) : (!TokenStream2) -> (!TokenStream)
        "return" (%snd) : (!TokenStream) -> ()
      }],
    rhs := [DCPlus_com| {
      ^entry(%c : !ValueStream_1, %d : !TokenStream):
        %fork = "DCPlus.fork" (%d) : (!TokenStream) -> (!TokenStream2)
        %snd = "DCPlus.snd" (%fork) : (!TokenStream2) -> (!TokenStream)
        %forkVal = "DCPlus.forkVal" (%c) : (!ValueStream_1) -> (!ValueStream2_1)
        %sndValPure = "DCPlus.sndValPure" (%forkVal) : (!ValueStream2_1) -> (!ValueStream_1)
        %supp = "DCPlus.supp" (%sndValPure, %snd) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
        "return" (%supp) : (!TokenStream) -> ()
      }],
    correct :=
    by sorry
    }

/- rewrite (i) is not feasible because of the feedback loop AFAIU -/
/- rewrite (j), (k) and (n) are not feasible because of the `sink` fake return type -/
/- rewrite (l) and (m) are not feasible because we don't have a ternary `fork` (and ternary coinduction) -/

def mkRewrite {Γ ty}
  (rw : PeepholeRewrite DCPlus Γ ty) :
  Σ Γ ty, PeepholeRewrite DCPlus Γ ty :=
  ⟨_, _, rw⟩

def rewrite_patterns : List (Σ Γ, Σ ty, PeepholeRewrite DCPlus Γ ty) :=[
  mkRewrite rewrite_a_T,
  mkRewrite rewrite_a_F,
  mkRewrite rewrite_c_A,
  mkRewrite rewrite_c_B,
  mkRewrite rewrite_h_A,
  mkRewrite rewrite_h_B,
  mkRewrite rewrite_g,
  mkRewrite rewrite_e,
]

def apply_patterns {Γl : List DCPlus.Ty} (fuel : Nat)
  (prog : Com DCPlus (Ctxt.ofList Γl) .pure ([.tokenstream])) :=
   multiRewritePeephole fuel rewrite_patterns prog


def example_program := [DCPlus_com| {
  ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
    %branch = "DCPlus.branch" (%1, %0) : (!ValueStream_1, !TokenStream) -> (!TokenStream2)
    %fst = "DCPlus.fst" (%branch) :  (!TokenStream2) -> (!TokenStream)
    "return" (%fst) : (!TokenStream) -> ()
  }]

#eval! apply_patterns 10 example_program
