(set-logic ALL)
(declare-const k Int)
(declare-fun C1 () (_ BitVec k))
(declare-fun %A () (_ BitVec k))
(declare-fun C2 () (_ BitVec k))
(assert (let ((_let_0 (ite (bvuge %A C1) %A C1))) (and (bvugt C1 C2) (not (= (ite (bvuge _let_0 C2) _let_0 C2) _let_0)))))
(check-sat)

