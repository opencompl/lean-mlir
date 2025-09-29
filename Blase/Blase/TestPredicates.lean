import Blase.SingleWidth.Defs

def Bits.testPredicates : Array Predicate := #[
Predicate.binary
        (BinaryPredicate.eq)
        (Term.sub
          (Term.sub
            (Term.sub
              (Term.sub
                (Term.add
                  (Term.add
                    (Term.add
                      (Term.add
                        (Term.not (Term.and (Term.var 0) (Term.not (Term.var 1))))
                        (Term.shiftL (Term.shiftL (Term.not (Term.and (Term.var 0) (Term.not (Term.var 1)))) 1) 1))
                      (Term.not (Term.var 0)))
                    (Term.add
                      (Term.not (Term.var 1))
                      (Term.add
                        (Term.shiftL (Term.not (Term.var 1)) 1)
                        (Term.shiftL (Term.shiftL (Term.shiftL (Term.not (Term.var 1)) 1) 1) 1))))
                  (Term.or (Term.var 0) (Term.var 1)))
                (Term.shiftL
                  (Term.shiftL (Term.shiftL (Term.shiftL (Term.not (Term.or (Term.var 0) (Term.var 1))) 1) 1) 1)
                  1))
              (Term.add
                (Term.not (Term.or (Term.var 0) (Term.not (Term.var 1))))
                (Term.add
                  (Term.shiftL (Term.not (Term.or (Term.var 0) (Term.not (Term.var 1)))) 1)
                  (Term.shiftL (Term.shiftL (Term.not (Term.or (Term.var 0) (Term.not (Term.var 1)))) 1) 1))))
            (Term.add
              (Term.and (Term.var 0) (Term.not (Term.var 1)))
              (Term.add
                (Term.shiftL (Term.and (Term.var 0) (Term.not (Term.var 1))) 1)
                (Term.shiftL (Term.shiftL (Term.shiftL (Term.and (Term.var 0) (Term.not (Term.var 1))) 1) 1) 1))))
          (Term.add
            (Term.and (Term.var 0) (Term.var 1))
            (Term.shiftL (Term.shiftL (Term.and (Term.var 0) (Term.var 1)) 1) 1)))
        (Term.or (Term.var 0) (Term.not (Term.var 1))),
Predicate.binary
        (BinaryPredicate.eq)
        (Term.sub
          (Term.sub
            (Term.sub
              (Term.add
                (Term.sub
                  (Term.sub
                    (Term.sub
                      (Term.add
                        (Term.sub
                          (Term.sub
                            (Term.sub
                              (Term.add
                                (Term.add
                                  (Term.sub
                                    (Term.sub
                                      (Term.add
                                        (Term.sub
                                          (Term.add
                                            (Term.add
                                              (Term.sub
                                                (Term.sub
                                                  (Term.sub
                                                    (Term.add
                                                      (Term.add
                                                        (Term.add
                                                          (Term.add
                                                            (Term.sub
                                                              (Term.add
                                                                (Term.sub
                                                                  (Term.add
                                                                    (Term.add
                                                                      (Term.add
                                                                        (Term.sub
                                                                          (Term.add
                                                                            (Term.add
                                                                              (Term.sub
                                                                                (Term.sub
                                                                                  (Term.add
                                                                                    (Term.add
                                                                                      (Term.sub
                                                                                        (Term.add
                                                                                          (Term.sub
                                                                                            (Term.add
                                                                                              (Term.sub
                                                                                                (Term.sub
                                                                                                  (Term.sub
                                                                                                    (Term.sub
                                                                                                      (Term.add
                                                                                                        (Term.add
                                                                                                          (Term.add
                                                                                                            (Term.add
                                                                                                              (Term.add
                                                                                                                (Term.add
                                                                                                                  (Term.sub
                                                                                                                    (Term.add
                                                                                                                      (Term.add
                                                                                                                        (Term.add
                                                                                                                          (Term.xor
                                                                                                                            (Term.var
                                                                                                                              0)
                                                                                                                            (Term.var
                                                                                                                              1))
                                                                                                                          (Term.xor
                                                                                                                            (Term.var
                                                                                                                              0)
                                                                                                                            (Term.var
                                                                                                                              1)))
                                                                                                                        (Term.add
                                                                                                                          (Term.xor
                                                                                                                            (Term.and
                                                                                                                              (Term.var
                                                                                                                                0)
                                                                                                                              (Term.var
                                                                                                                                1))
                                                                                                                            (Term.xor
                                                                                                                              (Term.var
                                                                                                                                0)
                                                                                                                              (Term.and
                                                                                                                                (Term.var
                                                                                                                                  1)
                                                                                                                                (Term.var
                                                                                                                                  2))))
                                                                                                                          (Term.shiftL
                                                                                                                            (Term.shiftL
                                                                                                                              (Term.xor
                                                                                                                                (Term.and
                                                                                                                                  (Term.var
                                                                                                                                    0)
                                                                                                                                  (Term.var
                                                                                                                                    1))
                                                                                                                                (Term.xor
                                                                                                                                  (Term.var
                                                                                                                                    0)
                                                                                                                                  (Term.and
                                                                                                                                    (Term.var
                                                                                                                                      1)
                                                                                                                                    (Term.var
                                                                                                                                      2))))
                                                                                                                              1)
                                                                                                                            1)))
                                                                                                                      (Term.xor
                                                                                                                        (Term.and
                                                                                                                          (Term.var
                                                                                                                            0)
                                                                                                                          (Term.var
                                                                                                                            2))
                                                                                                                        (Term.not
                                                                                                                          (Term.xor
                                                                                                                            (Term.var
                                                                                                                              0)
                                                                                                                            (Term.and
                                                                                                                              (Term.var
                                                                                                                                1)
                                                                                                                              (Term.var
                                                                                                                                2))))))
                                                                                                                    (Term.add
                                                                                                                      (Term.or
                                                                                                                        (Term.not
                                                                                                                          (Term.var
                                                                                                                            0))
                                                                                                                        (Term.or
                                                                                                                          (Term.var
                                                                                                                            1)
                                                                                                                          (Term.var
                                                                                                                            2)))
                                                                                                                      (Term.shiftL
                                                                                                                        (Term.shiftL
                                                                                                                          (Term.or
                                                                                                                            (Term.not
                                                                                                                              (Term.var
                                                                                                                                0))
                                                                                                                            (Term.or
                                                                                                                              (Term.var
                                                                                                                                1)
                                                                                                                              (Term.var
                                                                                                                                2)))
                                                                                                                          1)
                                                                                                                        1)))
                                                                                                                  (Term.add
                                                                                                                    (Term.xor
                                                                                                                      (Term.var
                                                                                                                        2)
                                                                                                                      (Term.not
                                                                                                                        (Term.and
                                                                                                                          (Term.var
                                                                                                                            0)
                                                                                                                          (Term.var
                                                                                                                            1))))
                                                                                                                    (Term.add
                                                                                                                      (Term.shiftL
                                                                                                                        (Term.xor
                                                                                                                          (Term.var
                                                                                                                            2)
                                                                                                                          (Term.not
                                                                                                                            (Term.and
                                                                                                                              (Term.var
                                                                                                                                0)
                                                                                                                              (Term.var
                                                                                                                                1))))
                                                                                                                        1)
                                                                                                                      (Term.shiftL
                                                                                                                        (Term.shiftL
                                                                                                                          (Term.shiftL
                                                                                                                            (Term.xor
                                                                                                                              (Term.var
                                                                                                                                2)
                                                                                                                              (Term.not
                                                                                                                                (Term.and
                                                                                                                                  (Term.var
                                                                                                                                    0)
                                                                                                                                  (Term.var
                                                                                                                                    1))))
                                                                                                                            1)
                                                                                                                          1)
                                                                                                                        1))))
                                                                                                                (Term.or
                                                                                                                  (Term.var
                                                                                                                    0)
                                                                                                                  (Term.and
                                                                                                                    (Term.var
                                                                                                                      1)
                                                                                                                    (Term.var
                                                                                                                      2))))
                                                                                                              (Term.and
                                                                                                                (Term.not
                                                                                                                  (Term.and
                                                                                                                    (Term.var
                                                                                                                      0)
                                                                                                                    (Term.var
                                                                                                                      1)))
                                                                                                                (Term.xor
                                                                                                                  (Term.var
                                                                                                                    1)
                                                                                                                  (Term.var
                                                                                                                    2))))
                                                                                                            (Term.add
                                                                                                              (Term.or
                                                                                                                (Term.not
                                                                                                                  (Term.or
                                                                                                                    (Term.var
                                                                                                                      0)
                                                                                                                    (Term.var
                                                                                                                      1)))
                                                                                                                (Term.not
                                                                                                                  (Term.xor
                                                                                                                    (Term.var
                                                                                                                      0)
                                                                                                                    (Term.xor
                                                                                                                      (Term.var
                                                                                                                        1)
                                                                                                                      (Term.var
                                                                                                                        2)))))
                                                                                                              (Term.shiftL
                                                                                                                (Term.shiftL
                                                                                                                  (Term.or
                                                                                                                    (Term.not
                                                                                                                      (Term.or
                                                                                                                        (Term.var
                                                                                                                          0)
                                                                                                                        (Term.var
                                                                                                                          1)))
                                                                                                                    (Term.not
                                                                                                                      (Term.xor
                                                                                                                        (Term.var
                                                                                                                          0)
                                                                                                                        (Term.xor
                                                                                                                          (Term.var
                                                                                                                            1)
                                                                                                                          (Term.var
                                                                                                                            2)))))
                                                                                                                  1)
                                                                                                                1)))
                                                                                                          (Term.shiftL
                                                                                                            (Term.shiftL
                                                                                                              (Term.xor
                                                                                                                (Term.var
                                                                                                                  1)
                                                                                                                (Term.and
                                                                                                                  (Term.not
                                                                                                                    (Term.var
                                                                                                                      0))
                                                                                                                  (Term.or
                                                                                                                    (Term.not
                                                                                                                      (Term.var
                                                                                                                        1))
                                                                                                                    (Term.var
                                                                                                                      2))))
                                                                                                              1)
                                                                                                            1))
                                                                                                        (Term.add
                                                                                                          (Term.xor
                                                                                                            (Term.var 0)
                                                                                                            (Term.and
                                                                                                              (Term.var
                                                                                                                1)
                                                                                                              (Term.var
                                                                                                                2)))
                                                                                                          (Term.xor
                                                                                                            (Term.var 0)
                                                                                                            (Term.and
                                                                                                              (Term.var
                                                                                                                1)
                                                                                                              (Term.var
                                                                                                                2)))))
                                                                                                      (Term.add
                                                                                                        (Term.xor
                                                                                                          (Term.var 1)
                                                                                                          (Term.not
                                                                                                            (Term.or
                                                                                                              (Term.var
                                                                                                                0)
                                                                                                              (Term.and
                                                                                                                (Term.var
                                                                                                                  1)
                                                                                                                (Term.var
                                                                                                                  2)))))
                                                                                                        (Term.shiftL
                                                                                                          (Term.shiftL
                                                                                                            (Term.xor
                                                                                                              (Term.var
                                                                                                                1)
                                                                                                              (Term.not
                                                                                                                (Term.or
                                                                                                                  (Term.var
                                                                                                                    0)
                                                                                                                  (Term.and
                                                                                                                    (Term.var
                                                                                                                      1)
                                                                                                                    (Term.var
                                                                                                                      2)))))
                                                                                                            1)
                                                                                                          1)))
                                                                                                    (Term.add
                                                                                                      (Term.shiftL
                                                                                                        (Term.xor
                                                                                                          (Term.var 1)
                                                                                                          (Term.or
                                                                                                            (Term.var 0)
                                                                                                            (Term.not
                                                                                                              (Term.var
                                                                                                                2))))
                                                                                                        1)
                                                                                                      (Term.shiftL
                                                                                                        (Term.shiftL
                                                                                                          (Term.xor
                                                                                                            (Term.var 1)
                                                                                                            (Term.or
                                                                                                              (Term.var
                                                                                                                0)
                                                                                                              (Term.not
                                                                                                                (Term.var
                                                                                                                  2))))
                                                                                                          1)
                                                                                                        1)))
                                                                                                  (Term.add
                                                                                                    (Term.xor
                                                                                                      (Term.var 2)
                                                                                                      (Term.or
                                                                                                        (Term.var 0)
                                                                                                        (Term.or
                                                                                                          (Term.var 1)
                                                                                                          (Term.var
                                                                                                            2))))
                                                                                                    (Term.xor
                                                                                                      (Term.var 2)
                                                                                                      (Term.or
                                                                                                        (Term.var 0)
                                                                                                        (Term.or
                                                                                                          (Term.var 1)
                                                                                                          (Term.var
                                                                                                            2))))))
                                                                                                (Term.add
                                                                                                  (Term.xor
                                                                                                    (Term.var 1)
                                                                                                    (Term.not
                                                                                                      (Term.or
                                                                                                        (Term.var 0)
                                                                                                        (Term.xor
                                                                                                          (Term.var 1)
                                                                                                          (Term.var
                                                                                                            2)))))
                                                                                                  (Term.xor
                                                                                                    (Term.var 1)
                                                                                                    (Term.not
                                                                                                      (Term.or
                                                                                                        (Term.var 0)
                                                                                                        (Term.xor
                                                                                                          (Term.var 1)
                                                                                                          (Term.var
                                                                                                            2)))))))
                                                                                              (Term.xor
                                                                                                (Term.var 2)
                                                                                                (Term.or
                                                                                                  (Term.var 0)
                                                                                                  (Term.or
                                                                                                    (Term.not
                                                                                                      (Term.var 1))
                                                                                                    (Term.var 2)))))
                                                                                            (Term.add
                                                                                              (Term.shiftL
                                                                                                (Term.not
                                                                                                  (Term.and
                                                                                                    (Term.var 1)
                                                                                                    (Term.var 2)))
                                                                                                1)
                                                                                              (Term.shiftL
                                                                                                (Term.shiftL
                                                                                                  (Term.not
                                                                                                    (Term.and
                                                                                                      (Term.var 1)
                                                                                                      (Term.var 2)))
                                                                                                  1)
                                                                                                1)))
                                                                                          (Term.and
                                                                                            (Term.not
                                                                                              (Term.xor
                                                                                                (Term.var 0)
                                                                                                (Term.var 1)))
                                                                                            (Term.xor
                                                                                              (Term.var 0)
                                                                                              (Term.var 2))))
                                                                                        (Term.add
                                                                                          (Term.shiftL
                                                                                            (Term.xor
                                                                                              (Term.var 2)
                                                                                              (Term.and
                                                                                                (Term.not (Term.var 0))
                                                                                                (Term.or
                                                                                                  (Term.var 1)
                                                                                                  (Term.var 2))))
                                                                                            1)
                                                                                          (Term.shiftL
                                                                                            (Term.shiftL
                                                                                              (Term.xor
                                                                                                (Term.var 2)
                                                                                                (Term.and
                                                                                                  (Term.not
                                                                                                    (Term.var 0))
                                                                                                  (Term.or
                                                                                                    (Term.var 1)
                                                                                                    (Term.var 2))))
                                                                                              1)
                                                                                            1)))
                                                                                      (Term.xor
                                                                                        (Term.var 1)
                                                                                        (Term.not
                                                                                          (Term.and
                                                                                            (Term.var 0)
                                                                                            (Term.or
                                                                                              (Term.not (Term.var 1))
                                                                                              (Term.var 2))))))
                                                                                    (Term.add
                                                                                      (Term.xor
                                                                                        (Term.var 2)
                                                                                        (Term.not
                                                                                          (Term.and
                                                                                            (Term.not (Term.var 0))
                                                                                            (Term.and
                                                                                              (Term.var 1)
                                                                                              (Term.var 2)))))
                                                                                      (Term.shiftL
                                                                                        (Term.shiftL
                                                                                          (Term.xor
                                                                                            (Term.var 2)
                                                                                            (Term.not
                                                                                              (Term.and
                                                                                                (Term.not (Term.var 0))
                                                                                                (Term.and
                                                                                                  (Term.var 1)
                                                                                                  (Term.var 2)))))
                                                                                          1)
                                                                                        1)))
                                                                                  (Term.add
                                                                                    (Term.or
                                                                                      (Term.and
                                                                                        (Term.var 1)
                                                                                        (Term.var 2))
                                                                                      (Term.and
                                                                                        (Term.var 0)
                                                                                        (Term.or
                                                                                          (Term.var 1)
                                                                                          (Term.var 2))))
                                                                                    (Term.add
                                                                                      (Term.shiftL
                                                                                        (Term.or
                                                                                          (Term.and
                                                                                            (Term.var 1)
                                                                                            (Term.var 2))
                                                                                          (Term.and
                                                                                            (Term.var 0)
                                                                                            (Term.or
                                                                                              (Term.var 1)
                                                                                              (Term.var 2))))
                                                                                        1)
                                                                                      (Term.shiftL
                                                                                        (Term.shiftL
                                                                                          (Term.or
                                                                                            (Term.and
                                                                                              (Term.var 1)
                                                                                              (Term.var 2))
                                                                                            (Term.and
                                                                                              (Term.var 0)
                                                                                              (Term.or
                                                                                                (Term.var 1)
                                                                                                (Term.var 2))))
                                                                                          1)
                                                                                        1))))
                                                                                (Term.or (Term.var 0) (Term.var 1)))
                                                                              (Term.add
                                                                                (Term.xor
                                                                                  (Term.var 1)
                                                                                  (Term.and
                                                                                    (Term.var 0)
                                                                                    (Term.or
                                                                                      (Term.not (Term.var 1))
                                                                                      (Term.var 2))))
                                                                                (Term.add
                                                                                  (Term.shiftL
                                                                                    (Term.xor
                                                                                      (Term.var 1)
                                                                                      (Term.and
                                                                                        (Term.var 0)
                                                                                        (Term.or
                                                                                          (Term.not (Term.var 1))
                                                                                          (Term.var 2))))
                                                                                    1)
                                                                                  (Term.shiftL
                                                                                    (Term.shiftL
                                                                                      (Term.shiftL
                                                                                        (Term.xor
                                                                                          (Term.var 1)
                                                                                          (Term.and
                                                                                            (Term.var 0)
                                                                                            (Term.or
                                                                                              (Term.not (Term.var 1))
                                                                                              (Term.var 2))))
                                                                                        1)
                                                                                      1)
                                                                                    1))))
                                                                            (Term.add
                                                                              (Term.not
                                                                                (Term.and
                                                                                  (Term.not (Term.var 0))
                                                                                  (Term.and
                                                                                    (Term.not (Term.var 1))
                                                                                    (Term.var 2))))
                                                                              (Term.add
                                                                                (Term.shiftL
                                                                                  (Term.not
                                                                                    (Term.and
                                                                                      (Term.not (Term.var 0))
                                                                                      (Term.and
                                                                                        (Term.not (Term.var 1))
                                                                                        (Term.var 2))))
                                                                                  1)
                                                                                (Term.shiftL
                                                                                  (Term.shiftL
                                                                                    (Term.not
                                                                                      (Term.and
                                                                                        (Term.not (Term.var 0))
                                                                                        (Term.and
                                                                                          (Term.not (Term.var 1))
                                                                                          (Term.var 2))))
                                                                                    1)
                                                                                  1))))
                                                                          (Term.add
                                                                            (Term.or
                                                                              (Term.and
                                                                                (Term.var 0)
                                                                                (Term.not (Term.var 1)))
                                                                              (Term.xor
                                                                                (Term.var 0)
                                                                                (Term.xor (Term.var 1) (Term.var 2))))
                                                                            (Term.or
                                                                              (Term.and
                                                                                (Term.var 0)
                                                                                (Term.not (Term.var 1)))
                                                                              (Term.xor
                                                                                (Term.var 0)
                                                                                (Term.xor (Term.var 1) (Term.var 2))))))
                                                                        (Term.add
                                                                          (Term.and
                                                                            (Term.not
                                                                              (Term.and (Term.var 0) (Term.var 1)))
                                                                            (Term.xor
                                                                              (Term.var 0)
                                                                              (Term.xor (Term.var 1) (Term.var 2))))
                                                                          (Term.shiftL
                                                                            (Term.and
                                                                              (Term.not
                                                                                (Term.and (Term.var 0) (Term.var 1)))
                                                                              (Term.xor
                                                                                (Term.var 0)
                                                                                (Term.xor (Term.var 1) (Term.var 2))))
                                                                            1)))
                                                                      (Term.add
                                                                        (Term.not
                                                                          (Term.xor
                                                                            (Term.var 0)
                                                                            (Term.xor (Term.var 1) (Term.var 2))))
                                                                        (Term.shiftL
                                                                          (Term.not
                                                                            (Term.xor
                                                                              (Term.var 0)
                                                                              (Term.xor (Term.var 1) (Term.var 2))))
                                                                          1)))
                                                                    (Term.shiftL
                                                                      (Term.shiftL
                                                                        (Term.or
                                                                          (Term.var 0)
                                                                          (Term.or
                                                                            (Term.not (Term.var 1))
                                                                            (Term.var 2)))
                                                                        1)
                                                                      1))
                                                                  (Term.add
                                                                    (Term.or (Term.var 0) (Term.var 2))
                                                                    (Term.add
                                                                      (Term.shiftL
                                                                        (Term.or (Term.var 0) (Term.var 2))
                                                                        1)
                                                                      (Term.shiftL
                                                                        (Term.shiftL
                                                                          (Term.or (Term.var 0) (Term.var 2))
                                                                          1)
                                                                        1))))
                                                                (Term.add
                                                                  (Term.xor
                                                                    (Term.var 2)
                                                                    (Term.or (Term.var 0) (Term.var 1)))
                                                                  (Term.add
                                                                    (Term.shiftL
                                                                      (Term.xor
                                                                        (Term.var 2)
                                                                        (Term.or (Term.var 0) (Term.var 1)))
                                                                      1)
                                                                    (Term.shiftL
                                                                      (Term.shiftL
                                                                        (Term.xor
                                                                          (Term.var 2)
                                                                          (Term.or (Term.var 0) (Term.var 1)))
                                                                        1)
                                                                      1))))
                                                              (Term.or
                                                                (Term.and (Term.var 0) (Term.var 1))
                                                                (Term.xor (Term.var 1) (Term.var 2))))
                                                            (Term.not (Term.or (Term.var 0) (Term.not (Term.var 2)))))
                                                          (Term.or
                                                            (Term.var 2)
                                                            (Term.and (Term.var 0) (Term.not (Term.var 1)))))
                                                        (Term.add
                                                          (Term.xor
                                                            (Term.var 1)
                                                            (Term.or (Term.var 0) (Term.and (Term.var 1) (Term.var 2))))
                                                          (Term.shiftL
                                                            (Term.xor
                                                              (Term.var 1)
                                                              (Term.or
                                                                (Term.var 0)
                                                                (Term.and (Term.var 1) (Term.var 2))))
                                                            1)))
                                                      (Term.add
                                                        (Term.and (Term.var 2) (Term.xor (Term.var 0) (Term.var 1)))
                                                        (Term.add
                                                          (Term.shiftL
                                                            (Term.and (Term.var 2) (Term.xor (Term.var 0) (Term.var 1)))
                                                            1)
                                                          (Term.shiftL
                                                            (Term.shiftL
                                                              (Term.shiftL
                                                                (Term.and
                                                                  (Term.var 2)
                                                                  (Term.xor (Term.var 0) (Term.var 1)))
                                                                1)
                                                              1)
                                                            1))))
                                                    (Term.add
                                                      (Term.or
                                                        (Term.xor (Term.var 0) (Term.var 1))
                                                        (Term.not (Term.xor (Term.var 0) (Term.var 2))))
                                                      (Term.or
                                                        (Term.xor (Term.var 0) (Term.var 1))
                                                        (Term.not (Term.xor (Term.var 0) (Term.var 2))))))
                                                  (Term.add
                                                    (Term.not (Term.or (Term.var 1) (Term.var 2)))
                                                    (Term.not (Term.or (Term.var 1) (Term.var 2)))))
                                                (Term.add
                                                  (Term.xor
                                                    (Term.var 1)
                                                    (Term.not
                                                      (Term.or
                                                        (Term.not (Term.var 0))
                                                        (Term.xor (Term.var 1) (Term.var 2)))))
                                                  (Term.shiftL
                                                    (Term.xor
                                                      (Term.var 1)
                                                      (Term.not
                                                        (Term.or
                                                          (Term.not (Term.var 0))
                                                          (Term.xor (Term.var 1) (Term.var 2)))))
                                                    1)))
                                              (Term.or (Term.not (Term.var 0)) (Term.xor (Term.var 1) (Term.var 2))))
                                            (Term.add
                                              (Term.not (Term.and (Term.var 1) (Term.not (Term.var 2))))
                                              (Term.add
                                                (Term.shiftL
                                                  (Term.not (Term.and (Term.var 1) (Term.not (Term.var 2))))
                                                  1)
                                                (Term.shiftL
                                                  (Term.shiftL
                                                    (Term.shiftL
                                                      (Term.not (Term.and (Term.var 1) (Term.not (Term.var 2))))
                                                      1)
                                                    1)
                                                  1))))
                                          (Term.add
                                            (Term.xor
                                              (Term.var 1)
                                              (Term.not
                                                (Term.and
                                                  (Term.var 0)
                                                  (Term.and (Term.not (Term.var 1)) (Term.var 2)))))
                                            (Term.add
                                              (Term.shiftL
                                                (Term.xor
                                                  (Term.var 1)
                                                  (Term.not
                                                    (Term.and
                                                      (Term.var 0)
                                                      (Term.and (Term.not (Term.var 1)) (Term.var 2)))))
                                                1)
                                              (Term.shiftL
                                                (Term.shiftL
                                                  (Term.shiftL
                                                    (Term.xor
                                                      (Term.var 1)
                                                      (Term.not
                                                        (Term.and
                                                          (Term.var 0)
                                                          (Term.and (Term.not (Term.var 1)) (Term.var 2)))))
                                                    1)
                                                  1)
                                                1))))
                                        (Term.xor
                                          (Term.and (Term.var 0) (Term.var 2))
                                          (Term.xor (Term.var 0) (Term.and (Term.var 1) (Term.var 2)))))
                                      (Term.and (Term.var 0) (Term.or (Term.not (Term.var 1)) (Term.var 2))))
                                    (Term.add
                                      (Term.and (Term.var 0) (Term.or (Term.var 1) (Term.var 2)))
                                      (Term.add
                                        (Term.shiftL (Term.and (Term.var 0) (Term.or (Term.var 1) (Term.var 2))) 1)
                                        (Term.shiftL
                                          (Term.shiftL (Term.and (Term.var 0) (Term.or (Term.var 1) (Term.var 2))) 1)
                                          1))))
                                  (Term.add
                                    (Term.not (Term.xor (Term.var 1) (Term.var 2)))
                                    (Term.add
                                      (Term.shiftL (Term.not (Term.xor (Term.var 1) (Term.var 2))) 1)
                                      (Term.shiftL (Term.shiftL (Term.not (Term.xor (Term.var 1) (Term.var 2))) 1) 1))))
                                (Term.and (Term.var 0) (Term.not (Term.var 1))))
                              (Term.add
                                (Term.shiftL
                                  (Term.xor
                                    (Term.var 1)
                                    (Term.not (Term.and (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2)))))
                                  1)
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.xor
                                      (Term.var 1)
                                      (Term.not (Term.and (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2)))))
                                    1)
                                  1)))
                            (Term.add
                              (Term.and (Term.not (Term.var 0)) (Term.or (Term.not (Term.var 1)) (Term.var 2)))
                              (Term.add
                                (Term.shiftL
                                  (Term.and (Term.not (Term.var 0)) (Term.or (Term.not (Term.var 1)) (Term.var 2)))
                                  1)
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.shiftL
                                      (Term.and (Term.not (Term.var 0)) (Term.or (Term.not (Term.var 1)) (Term.var 2)))
                                      1)
                                    1)
                                  1))))
                          (Term.add
                            (Term.or
                              (Term.not (Term.xor (Term.var 0) (Term.var 1)))
                              (Term.xor (Term.var 0) (Term.var 2)))
                            (Term.shiftL
                              (Term.shiftL
                                (Term.or
                                  (Term.not (Term.xor (Term.var 0) (Term.var 1)))
                                  (Term.xor (Term.var 0) (Term.var 2)))
                                1)
                              1)))
                        (Term.not (Term.or (Term.var 0) (Term.or (Term.var 1) (Term.var 2)))))
                      (Term.add
                        (Term.shiftL
                          (Term.shiftL
                            (Term.not (Term.or (Term.var 0) (Term.or (Term.not (Term.var 1)) (Term.var 2))))
                            1)
                          1)
                        (Term.shiftL
                          (Term.shiftL
                            (Term.shiftL
                              (Term.shiftL
                                (Term.not (Term.or (Term.var 0) (Term.or (Term.not (Term.var 1)) (Term.var 2))))
                                1)
                              1)
                            1)
                          1)))
                    (Term.add
                      (Term.not (Term.or (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2))))
                      (Term.add
                        (Term.shiftL (Term.not (Term.or (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2)))) 1)
                        (Term.add
                          (Term.shiftL
                            (Term.shiftL
                              (Term.not (Term.or (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2))))
                              1)
                            1)
                          (Term.add
                            (Term.shiftL
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.not (Term.or (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2))))
                                  1)
                                1)
                              1)
                            (Term.shiftL
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.not (Term.or (Term.not (Term.var 0)) (Term.or (Term.var 1) (Term.var 2))))
                                    1)
                                  1)
                                1)
                              1))))))
                  (Term.not (Term.or (Term.not (Term.var 0)) (Term.or (Term.not (Term.var 1)) (Term.var 2)))))
                (Term.add
                  (Term.and (Term.not (Term.var 0)) (Term.and (Term.not (Term.var 1)) (Term.var 2)))
                  (Term.add
                    (Term.shiftL (Term.and (Term.not (Term.var 0)) (Term.and (Term.not (Term.var 1)) (Term.var 2))) 1)
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL
                          (Term.and (Term.not (Term.var 0)) (Term.and (Term.not (Term.var 1)) (Term.var 2)))
                          1)
                        1)
                      1))))
              (Term.add
                (Term.and (Term.not (Term.var 0)) (Term.and (Term.var 1) (Term.var 2)))
                (Term.add
                  (Term.shiftL (Term.and (Term.not (Term.var 0)) (Term.and (Term.var 1) (Term.var 2))) 1)
                  (Term.shiftL
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL (Term.and (Term.not (Term.var 0)) (Term.and (Term.var 1) (Term.var 2))) 1)
                        1)
                      1)
                    1))))
            (Term.add
              (Term.and (Term.var 0) (Term.and (Term.not (Term.var 1)) (Term.var 2)))
              (Term.add
                (Term.shiftL (Term.and (Term.var 0) (Term.and (Term.not (Term.var 1)) (Term.var 2))) 1)
                (Term.add
                  (Term.shiftL
                    (Term.shiftL (Term.and (Term.var 0) (Term.and (Term.not (Term.var 1)) (Term.var 2))) 1)
                    1)
                  (Term.shiftL
                    (Term.shiftL
                      (Term.shiftL (Term.and (Term.var 0) (Term.and (Term.not (Term.var 1)) (Term.var 2))) 1)
                      1)
                    1)))))
          (Term.add
            (Term.and (Term.var 0) (Term.and (Term.var 1) (Term.var 2)))
            (Term.and (Term.var 0) (Term.and (Term.var 1) (Term.var 2)))))
        (Term.add
          (Term.neg (Term.shiftL (Term.xor (Term.var 1) (Term.or (Term.var 0) (Term.or (Term.var 1) (Term.var 2)))) 1))
          (Term.xor (Term.var 0) (Term.or (Term.not (Term.var 1)) (Term.var 2))))
,
     Predicate.binary
        (BinaryPredicate.eq)
        (Term.add
          (Term.sub
            (Term.sub
              (Term.add
                (Term.sub
                  (Term.sub
                    (Term.sub
                      (Term.sub
                        (Term.add
                          (Term.sub
                            (Term.add
                              (Term.add
                                (Term.sub
                                  (Term.sub
                                    (Term.sub
                                      (Term.add
                                        (Term.sub
                                          (Term.sub
                                            (Term.add
                                              (Term.sub
                                                (Term.sub
                                                  (Term.add
                                                    (Term.sub
                                                      (Term.add
                                                        (Term.sub
                                                          (Term.add
                                                            (Term.sub
                                                              (Term.sub
                                                                (Term.sub
                                                                  (Term.add
                                                                    (Term.add
                                                                      (Term.sub
                                                                        (Term.sub
                                                                          (Term.sub
                                                                            (Term.add
                                                                              (Term.sub
                                                                                (Term.add
                                                                                  (Term.add
                                                                                    (Term.add
                                                                                      (Term.sub
                                                                                        (Term.sub
                                                                                          (Term.sub
                                                                                            (Term.add
                                                                                              (Term.sub
                                                                                                (Term.add
                                                                                                  (Term.add
                                                                                                    (Term.add
                                                                                                      (Term.add
                                                                                                        (Term.add
                                                                                                          (Term.sub
                                                                                                            (Term.add
                                                                                                              (Term.add
                                                                                                                (Term.sub
                                                                                                                  (Term.sub
                                                                                                                    (Term.sub
                                                                                                                      (Term.sub
                                                                                                                        (Term.add
                                                                                                                          (Term.sub
                                                                                                                            (Term.add
                                                                                                                              (Term.add
                                                                                                                                (Term.add
                                                                                                                                  (Term.sub
                                                                                                                                    (Term.sub
                                                                                                                                      (Term.add
                                                                                                                                        (Term.add
                                                                                                                                          (Term.add
                                                                                                                                            (Term.add
                                                                                                                                              (Term.add
                                                                                                                                                (Term.add
                                                                                                                                                  (Term.add
                                                                                                                                                    (Term.sub
                                                                                                                                                      (Term.add
                                                                                                                                                        (Term.add
                                                                                                                                                          (Term.add
                                                                                                                                                            (Term.add
                                                                                                                                                              (Term.add
                                                                                                                                                                (Term.sub
                                                                                                                                                                  (Term.add
                                                                                                                                                                    (Term.sub
                                                                                                                                                                      (Term.sub
                                                                                                                                                                        (Term.sub
                                                                                                                                                                          (Term.add
                                                                                                                                                                            (Term.or
                                                                                                                                                                              (Term.not
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  0))
                                                                                                                                                                              (Term.xor
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  1)
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  2)))
                                                                                                                                                                            (Term.add
                                                                                                                                                                              (Term.shiftL
                                                                                                                                                                                (Term.or
                                                                                                                                                                                  (Term.not
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      0))
                                                                                                                                                                                  (Term.xor
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      1)
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      2)))
                                                                                                                                                                                1)
                                                                                                                                                                              (Term.shiftL
                                                                                                                                                                                (Term.shiftL
                                                                                                                                                                                  (Term.or
                                                                                                                                                                                    (Term.not
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        0))
                                                                                                                                                                                    (Term.xor
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        1)
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        2)))
                                                                                                                                                                                  1)
                                                                                                                                                                                1)))
                                                                                                                                                                          (Term.add
                                                                                                                                                                            (Term.shiftL
                                                                                                                                                                              (Term.and
                                                                                                                                                                                (Term.not
                                                                                                                                                                                  (Term.and
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      1)
                                                                                                                                                                                    (Term.not
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        2))))
                                                                                                                                                                                (Term.xor
                                                                                                                                                                                  (Term.var
                                                                                                                                                                                    2)
                                                                                                                                                                                  (Term.var
                                                                                                                                                                                    0)))
                                                                                                                                                                              1)
                                                                                                                                                                            (Term.shiftL
                                                                                                                                                                              (Term.shiftL
                                                                                                                                                                                (Term.and
                                                                                                                                                                                  (Term.not
                                                                                                                                                                                    (Term.and
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        1)
                                                                                                                                                                                      (Term.not
                                                                                                                                                                                        (Term.var
                                                                                                                                                                                          2))))
                                                                                                                                                                                  (Term.xor
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      2)
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      0)))
                                                                                                                                                                                1)
                                                                                                                                                                              1)))
                                                                                                                                                                        (Term.add
                                                                                                                                                                          (Term.and
                                                                                                                                                                            (Term.not
                                                                                                                                                                              (Term.and
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  1)
                                                                                                                                                                                (Term.not
                                                                                                                                                                                  (Term.var
                                                                                                                                                                                    2))))
                                                                                                                                                                            (Term.xor
                                                                                                                                                                              (Term.var
                                                                                                                                                                                1)
                                                                                                                                                                              (Term.xor
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  2)
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  0))))
                                                                                                                                                                          (Term.add
                                                                                                                                                                            (Term.shiftL
                                                                                                                                                                              (Term.and
                                                                                                                                                                                (Term.not
                                                                                                                                                                                  (Term.and
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      1)
                                                                                                                                                                                    (Term.not
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        2))))
                                                                                                                                                                                (Term.xor
                                                                                                                                                                                  (Term.var
                                                                                                                                                                                    1)
                                                                                                                                                                                  (Term.xor
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      2)
                                                                                                                                                                                    (Term.var
                                                                                                                                                                                      0))))
                                                                                                                                                                              1)
                                                                                                                                                                            (Term.shiftL
                                                                                                                                                                              (Term.shiftL
                                                                                                                                                                                (Term.shiftL
                                                                                                                                                                                  (Term.and
                                                                                                                                                                                    (Term.not
                                                                                                                                                                                      (Term.and
                                                                                                                                                                                        (Term.var
                                                                                                                                                                                          1)
                                                                                                                                                                                        (Term.not
                                                                                                                                                                                          (Term.var
                                                                                                                                                                                            2))))
                                                                                                                                                                                    (Term.xor
                                                                                                                                                                                      (Term.var
                                                                                                                                                                                        1)
                                                                                                                                                                                      (Term.xor
                                                                                                                                                                                        (Term.var
                                                                                                                                                                                          2)
                                                                                                                                                                                        (Term.var
                                                                                                                                                                                          0))))
                                                                                                                                                                                  1)
                                                                                                                                                                                1)
                                                                                                                                                                              1))))
                                                                                                                                                                      (Term.xor
                                                                                                                                                                        (Term.var
                                                                                                                                                                          0)
                                                                                                                                                                        (Term.not
                                                                                                                                                                          (Term.and
                                                                                                                                                                            (Term.not
                                                                                                                                                                              (Term.var
                                                                                                                                                                                1))
                                                                                                                                                                            (Term.or
                                                                                                                                                                              (Term.var
                                                                                                                                                                                2)
                                                                                                                                                                              (Term.var
                                                                                                                                                                                0))))))
                                                                                                                                                                    (Term.add
                                                                                                                                                                      (Term.or
                                                                                                                                                                        (Term.and
                                                                                                                                                                          (Term.var
                                                                                                                                                                            2)
                                                                                                                                                                          (Term.not
                                                                                                                                                                            (Term.var
                                                                                                                                                                              0)))
                                                                                                                                                                        (Term.not
                                                                                                                                                                          (Term.or
                                                                                                                                                                            (Term.var
                                                                                                                                                                              1)
                                                                                                                                                                            (Term.and
                                                                                                                                                                              (Term.not
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  2))
                                                                                                                                                                              (Term.var
                                                                                                                                                                                0)))))
                                                                                                                                                                      (Term.shiftL
                                                                                                                                                                        (Term.or
                                                                                                                                                                          (Term.and
                                                                                                                                                                            (Term.var
                                                                                                                                                                              2)
                                                                                                                                                                            (Term.not
                                                                                                                                                                              (Term.var
                                                                                                                                                                                0)))
                                                                                                                                                                          (Term.not
                                                                                                                                                                            (Term.or
                                                                                                                                                                              (Term.var
                                                                                                                                                                                1)
                                                                                                                                                                              (Term.and
                                                                                                                                                                                (Term.not
                                                                                                                                                                                  (Term.var
                                                                                                                                                                                    2))
                                                                                                                                                                                (Term.var
                                                                                                                                                                                  0)))))
                                                                                                                                                                        1)))
                                                                                                                                                                  (Term.add
                                                                                                                                                                    (Term.or
                                                                                                                                                                      (Term.var
                                                                                                                                                                        0)
                                                                                                                                                                      (Term.not
                                                                                                                                                                        (Term.or
                                                                                                                                                                          (Term.var
                                                                                                                                                                            1)
                                                                                                                                                                          (Term.not
                                                                                                                                                                            (Term.var
                                                                                                                                                                              2)))))
                                                                                                                                                                    (Term.shiftL
                                                                                                                                                                      (Term.or
                                                                                                                                                                        (Term.var
                                                                                                                                                                          0)
                                                                                                                                                                        (Term.not
                                                                                                                                                                          (Term.or
                                                                                                                                                                            (Term.var
                                                                                                                                                                              1)
                                                                                                                                                                            (Term.not
                                                                                                                                                                              (Term.var
                                                                                                                                                                                2)))))
                                                                                                                                                                      1)))
                                                                                                                                                                (Term.not
                                                                                                                                                                  (Term.xor
                                                                                                                                                                    (Term.var
                                                                                                                                                                      2)
                                                                                                                                                                    (Term.var
                                                                                                                                                                      0))))
                                                                                                                                                              (Term.not
                                                                                                                                                                (Term.and
                                                                                                                                                                  (Term.var
                                                                                                                                                                    1)
                                                                                                                                                                  (Term.or
                                                                                                                                                                    (Term.var
                                                                                                                                                                      2)
                                                                                                                                                                    (Term.var
                                                                                                                                                                      0)))))
                                                                                                                                                            (Term.add
                                                                                                                                                              (Term.or
                                                                                                                                                                (Term.not
                                                                                                                                                                  (Term.or
                                                                                                                                                                    (Term.var
                                                                                                                                                                      1)
                                                                                                                                                                    (Term.not
                                                                                                                                                                      (Term.var
                                                                                                                                                                        2))))
                                                                                                                                                                (Term.xor
                                                                                                                                                                  (Term.var
                                                                                                                                                                    1)
                                                                                                                                                                  (Term.xor
                                                                                                                                                                    (Term.var
                                                                                                                                                                      2)
                                                                                                                                                                    (Term.var
                                                                                                                                                                      0))))
                                                                                                                                                              (Term.shiftL
                                                                                                                                                                (Term.shiftL
                                                                                                                                                                  (Term.or
                                                                                                                                                                    (Term.not
                                                                                                                                                                      (Term.or
                                                                                                                                                                        (Term.var
                                                                                                                                                                          1)
                                                                                                                                                                        (Term.not
                                                                                                                                                                          (Term.var
                                                                                                                                                                            2))))
                                                                                                                                                                    (Term.xor
                                                                                                                                                                      (Term.var
                                                                                                                                                                        1)
                                                                                                                                                                      (Term.xor
                                                                                                                                                                        (Term.var
                                                                                                                                                                          2)
                                                                                                                                                                        (Term.var
                                                                                                                                                                          0))))
                                                                                                                                                                  1)
                                                                                                                                                                1)))
                                                                                                                                                          (Term.xor
                                                                                                                                                            (Term.var
                                                                                                                                                              2)
                                                                                                                                                            (Term.not
                                                                                                                                                              (Term.or
                                                                                                                                                                (Term.var
                                                                                                                                                                  1)
                                                                                                                                                                (Term.and
                                                                                                                                                                  (Term.var
                                                                                                                                                                    2)
                                                                                                                                                                  (Term.var
                                                                                                                                                                    0))))))
                                                                                                                                                        (Term.not
                                                                                                                                                          (Term.or
                                                                                                                                                            (Term.var
                                                                                                                                                              1)
                                                                                                                                                            (Term.and
                                                                                                                                                              (Term.not
                                                                                                                                                                (Term.var
                                                                                                                                                                  2))
                                                                                                                                                              (Term.var
                                                                                                                                                                0)))))
                                                                                                                                                      (Term.or
                                                                                                                                                        (Term.not
                                                                                                                                                          (Term.var
                                                                                                                                                            1))
                                                                                                                                                        (Term.xor
                                                                                                                                                          (Term.var
                                                                                                                                                            2)
                                                                                                                                                          (Term.var
                                                                                                                                                            0))))
                                                                                                                                                    (Term.shiftL
                                                                                                                                                      (Term.shiftL
                                                                                                                                                        (Term.xor
                                                                                                                                                          (Term.var
                                                                                                                                                            2)
                                                                                                                                                          (Term.not
                                                                                                                                                            (Term.and
                                                                                                                                                              (Term.not
                                                                                                                                                                (Term.var
                                                                                                                                                                  1))
                                                                                                                                                              (Term.or
                                                                                                                                                                (Term.var
                                                                                                                                                                  2)
                                                                                                                                                                (Term.var
                                                                                                                                                                  0)))))
                                                                                                                                                        1)
                                                                                                                                                      1))
                                                                                                                                                  (Term.add
                                                                                                                                                    (Term.or
                                                                                                                                                      (Term.and
                                                                                                                                                        (Term.var
                                                                                                                                                          1)
                                                                                                                                                        (Term.not
                                                                                                                                                          (Term.var
                                                                                                                                                            2)))
                                                                                                                                                      (Term.not
                                                                                                                                                        (Term.xor
                                                                                                                                                          (Term.var
                                                                                                                                                            2)
                                                                                                                                                          (Term.var
                                                                                                                                                            0))))
                                                                                                                                                    (Term.shiftL
                                                                                                                                                      (Term.or
                                                                                                                                                        (Term.and
                                                                                                                                                          (Term.var
                                                                                                                                                            1)
                                                                                                                                                          (Term.not
                                                                                                                                                            (Term.var
                                                                                                                                                              2)))
                                                                                                                                                        (Term.not
                                                                                                                                                          (Term.xor
                                                                                                                                                            (Term.var
                                                                                                                                                              2)
                                                                                                                                                            (Term.var
                                                                                                                                                              0))))
                                                                                                                                                      1)))
                                                                                                                                                (Term.shiftL
                                                                                                                                                  (Term.shiftL
                                                                                                                                                    (Term.xor
                                                                                                                                                      (Term.var
                                                                                                                                                        0)
                                                                                                                                                      (Term.or
                                                                                                                                                        (Term.not
                                                                                                                                                          (Term.var
                                                                                                                                                            1))
                                                                                                                                                        (Term.or
                                                                                                                                                          (Term.not
                                                                                                                                                            (Term.var
                                                                                                                                                              2))
                                                                                                                                                          (Term.var
                                                                                                                                                            0))))
                                                                                                                                                    1)
                                                                                                                                                  1))
                                                                                                                                              (Term.shiftL
                                                                                                                                                (Term.shiftL
                                                                                                                                                  (Term.xor
                                                                                                                                                    (Term.and
                                                                                                                                                      (Term.var
                                                                                                                                                        2)
                                                                                                                                                      (Term.not
                                                                                                                                                        (Term.var
                                                                                                                                                          0)))
                                                                                                                                                    (Term.or
                                                                                                                                                      (Term.var
                                                                                                                                                        1)
                                                                                                                                                      (Term.xor
                                                                                                                                                        (Term.var
                                                                                                                                                          2)
                                                                                                                                                        (Term.var
                                                                                                                                                          0))))
                                                                                                                                                  1)
                                                                                                                                                1))
                                                                                                                                            (Term.add
                                                                                                                                              (Term.or
                                                                                                                                                (Term.and
                                                                                                                                                  (Term.var
                                                                                                                                                    1)
                                                                                                                                                  (Term.not
                                                                                                                                                    (Term.var
                                                                                                                                                      2)))
                                                                                                                                                (Term.xor
                                                                                                                                                  (Term.var
                                                                                                                                                    2)
                                                                                                                                                  (Term.var
                                                                                                                                                    0)))
                                                                                                                                              (Term.add
                                                                                                                                                (Term.shiftL
                                                                                                                                                  (Term.or
                                                                                                                                                    (Term.and
                                                                                                                                                      (Term.var
                                                                                                                                                        1)
                                                                                                                                                      (Term.not
                                                                                                                                                        (Term.var
                                                                                                                                                          2)))
                                                                                                                                                    (Term.xor
                                                                                                                                                      (Term.var
                                                                                                                                                        2)
                                                                                                                                                      (Term.var
                                                                                                                                                        0)))
                                                                                                                                                  1)
                                                                                                                                                (Term.shiftL
                                                                                                                                                  (Term.shiftL
                                                                                                                                                    (Term.or
                                                                                                                                                      (Term.and
                                                                                                                                                        (Term.var
                                                                                                                                                          1)
                                                                                                                                                        (Term.not
                                                                                                                                                          (Term.var
                                                                                                                                                            2)))
                                                                                                                                                      (Term.xor
                                                                                                                                                        (Term.var
                                                                                                                                                          2)
                                                                                                                                                        (Term.var
                                                                                                                                                          0)))
                                                                                                                                                    1)
                                                                                                                                                  1))))
                                                                                                                                          (Term.add
                                                                                                                                            (Term.and
                                                                                                                                              (Term.or
                                                                                                                                                (Term.var
                                                                                                                                                  1)
                                                                                                                                                (Term.var
                                                                                                                                                  2))
                                                                                                                                              (Term.xor
                                                                                                                                                (Term.var
                                                                                                                                                  2)
                                                                                                                                                (Term.var
                                                                                                                                                  0)))
                                                                                                                                            (Term.and
                                                                                                                                              (Term.or
                                                                                                                                                (Term.var
                                                                                                                                                  1)
                                                                                                                                                (Term.var
                                                                                                                                                  2))
                                                                                                                                              (Term.xor
                                                                                                                                                (Term.var
                                                                                                                                                  2)
                                                                                                                                                (Term.var
                                                                                                                                                  0)))))
                                                                                                                                        (Term.add
                                                                                                                                          (Term.xor
                                                                                                                                            (Term.var
                                                                                                                                              2)
                                                                                                                                            (Term.not
                                                                                                                                              (Term.or
                                                                                                                                                (Term.not
                                                                                                                                                  (Term.var
                                                                                                                                                    1))
                                                                                                                                                (Term.xor
                                                                                                                                                  (Term.var
                                                                                                                                                    2)
                                                                                                                                                  (Term.var
                                                                                                                                                    0)))))
                                                                                                                                          (Term.shiftL
                                                                                                                                            (Term.xor
                                                                                                                                              (Term.var
                                                                                                                                                2)
                                                                                                                                              (Term.not
                                                                                                                                                (Term.or
                                                                                                                                                  (Term.not
                                                                                                                                                    (Term.var
                                                                                                                                                      1))
                                                                                                                                                  (Term.xor
                                                                                                                                                    (Term.var
                                                                                                                                                      2)
                                                                                                                                                    (Term.var
                                                                                                                                                      0)))))
                                                                                                                                            1)))
                                                                                                                                      (Term.add
                                                                                                                                        (Term.shiftL
                                                                                                                                          (Term.xor
                                                                                                                                            (Term.var
                                                                                                                                              2)
                                                                                                                                            (Term.not
                                                                                                                                              (Term.and
                                                                                                                                                (Term.var
                                                                                                                                                  1)
                                                                                                                                                (Term.var
                                                                                                                                                  0))))
                                                                                                                                          1)
                                                                                                                                        (Term.shiftL
                                                                                                                                          (Term.shiftL
                                                                                                                                            (Term.xor
                                                                                                                                              (Term.var
                                                                                                                                                2)
                                                                                                                                              (Term.not
                                                                                                                                                (Term.and
                                                                                                                                                  (Term.var
                                                                                                                                                    1)
                                                                                                                                                  (Term.var
                                                                                                                                                    0))))
                                                                                                                                            1)
                                                                                                                                          1)))
                                                                                                                                    (Term.xor
                                                                                                                                      (Term.var
                                                                                                                                        2)
                                                                                                                                      (Term.or
                                                                                                                                        (Term.not
                                                                                                                                          (Term.var
                                                                                                                                            1))
                                                                                                                                        (Term.or
                                                                                                                                          (Term.var
                                                                                                                                            2)
                                                                                                                                          (Term.var
                                                                                                                                            0)))))
                                                                                                                                  (Term.add
                                                                                                                                    (Term.xor
                                                                                                                                      (Term.var
                                                                                                                                        0)
                                                                                                                                      (Term.and
                                                                                                                                        (Term.var
                                                                                                                                          1)
                                                                                                                                        (Term.or
                                                                                                                                          (Term.var
                                                                                                                                            2)
                                                                                                                                          (Term.var
                                                                                                                                            0))))
                                                                                                                                    (Term.shiftL
                                                                                                                                      (Term.shiftL
                                                                                                                                        (Term.xor
                                                                                                                                          (Term.var
                                                                                                                                            0)
                                                                                                                                          (Term.and
                                                                                                                                            (Term.var
                                                                                                                                              1)
                                                                                                                                            (Term.or
                                                                                                                                              (Term.var
                                                                                                                                                2)
                                                                                                                                              (Term.var
                                                                                                                                                0))))
                                                                                                                                        1)
                                                                                                                                      1)))
                                                                                                                                (Term.shiftL
                                                                                                                                  (Term.shiftL
                                                                                                                                    (Term.xor
                                                                                                                                      (Term.and
                                                                                                                                        (Term.var
                                                                                                                                          1)
                                                                                                                                        (Term.var
                                                                                                                                          0))
                                                                                                                                      (Term.or
                                                                                                                                        (Term.var
                                                                                                                                          2)
                                                                                                                                        (Term.var
                                                                                                                                          0)))
                                                                                                                                    1)
                                                                                                                                  1))
                                                                                                                              (Term.and
                                                                                                                                (Term.var
                                                                                                                                  2)
                                                                                                                                (Term.or
                                                                                                                                  (Term.var
                                                                                                                                    1)
                                                                                                                                  (Term.not
                                                                                                                                    (Term.var
                                                                                                                                      0)))))
                                                                                                                            (Term.add
                                                                                                                              (Term.not
                                                                                                                                (Term.and
                                                                                                                                  (Term.var
                                                                                                                                    1)
                                                                                                                                  (Term.not
                                                                                                                                    (Term.var
                                                                                                                                      2))))
                                                                                                                              (Term.not
                                                                                                                                (Term.and
                                                                                                                                  (Term.var
                                                                                                                                    1)
                                                                                                                                  (Term.not
                                                                                                                                    (Term.var
                                                                                                                                      2))))))
                                                                                                                          (Term.add
                                                                                                                            (Term.xor
                                                                                                                              (Term.var
                                                                                                                                0)
                                                                                                                              (Term.not
                                                                                                                                (Term.and
                                                                                                                                  (Term.not
                                                                                                                                    (Term.var
                                                                                                                                      1))
                                                                                                                                  (Term.or
                                                                                                                                    (Term.not
                                                                                                                                      (Term.var
                                                                                                                                        2))
                                                                                                                                    (Term.var
                                                                                                                                      0)))))
                                                                                                                            (Term.add
                                                                                                                              (Term.shiftL
                                                                                                                                (Term.xor
                                                                                                                                  (Term.var
                                                                                                                                    0)
                                                                                                                                  (Term.not
                                                                                                                                    (Term.and
                                                                                                                                      (Term.not
                                                                                                                                        (Term.var
                                                                                                                                          1))
                                                                                                                                      (Term.or
                                                                                                                                        (Term.not
                                                                                                                                          (Term.var
                                                                                                                                            2))
                                                                                                                                        (Term.var
                                                                                                                                          0)))))
                                                                                                                                1)
                                                                                                                              (Term.shiftL
                                                                                                                                (Term.shiftL
                                                                                                                                  (Term.xor
                                                                                                                                    (Term.var
                                                                                                                                      0)
                                                                                                                                    (Term.not
                                                                                                                                      (Term.and
                                                                                                                                        (Term.not
                                                                                                                                          (Term.var
                                                                                                                                            1))
                                                                                                                                        (Term.or
                                                                                                                                          (Term.not
                                                                                                                                            (Term.var
                                                                                                                                              2))
                                                                                                                                          (Term.var
                                                                                                                                            0)))))
                                                                                                                                  1)
                                                                                                                                1))))
                                                                                                                        (Term.add
                                                                                                                          (Term.or
                                                                                                                            (Term.and
                                                                                                                              (Term.var
                                                                                                                                1)
                                                                                                                              (Term.var
                                                                                                                                2))
                                                                                                                            (Term.not
                                                                                                                              (Term.xor
                                                                                                                                (Term.var
                                                                                                                                  2)
                                                                                                                                (Term.var
                                                                                                                                  0))))
                                                                                                                          (Term.shiftL
                                                                                                                            (Term.or
                                                                                                                              (Term.and
                                                                                                                                (Term.var
                                                                                                                                  1)
                                                                                                                                (Term.var
                                                                                                                                  2))
                                                                                                                              (Term.not
                                                                                                                                (Term.xor
                                                                                                                                  (Term.var
                                                                                                                                    2)
                                                                                                                                  (Term.var
                                                                                                                                    0))))
                                                                                                                            1)))
                                                                                                                      (Term.not
                                                                                                                        (Term.and
                                                                                                                          (Term.not
                                                                                                                            (Term.var
                                                                                                                              1))
                                                                                                                          (Term.or
                                                                                                                            (Term.not
                                                                                                                              (Term.var
                                                                                                                                2))
                                                                                                                            (Term.var
                                                                                                                              0)))))
                                                                                                                    (Term.add
                                                                                                                      (Term.xor
                                                                                                                        (Term.var
                                                                                                                          0)
                                                                                                                        (Term.or
                                                                                                                          (Term.not
                                                                                                                            (Term.var
                                                                                                                              1))
                                                                                                                          (Term.and
                                                                                                                            (Term.var
                                                                                                                              2)
                                                                                                                            (Term.var
                                                                                                                              0))))
                                                                                                                      (Term.shiftL
                                                                                                                        (Term.shiftL
                                                                                                                          (Term.xor
                                                                                                                            (Term.var
                                                                                                                              0)
                                                                                                                            (Term.or
                                                                                                                              (Term.not
                                                                                                                                (Term.var
                                                                                                                                  1))
                                                                                                                              (Term.and
                                                                                                                                (Term.var
                                                                                                                                  2)
                                                                                                                                (Term.var
                                                                                                                                  0))))
                                                                                                                          1)
                                                                                                                        1)))
                                                                                                                  (Term.or
                                                                                                                    (Term.var
                                                                                                                      1)
                                                                                                                    (Term.or
                                                                                                                      (Term.var
                                                                                                                        2)
                                                                                                                      (Term.var
                                                                                                                        0))))
                                                                                                                (Term.add
                                                                                                                  (Term.and
                                                                                                                    (Term.var
                                                                                                                      1)
                                                                                                                    (Term.not
                                                                                                                      (Term.var
                                                                                                                        0)))
                                                                                                                  (Term.shiftL
                                                                                                                    (Term.shiftL
                                                                                                                      (Term.and
                                                                                                                        (Term.var
                                                                                                                          1)
                                                                                                                        (Term.not
                                                                                                                          (Term.var
                                                                                                                            0)))
                                                                                                                      1)
                                                                                                                    1)))
                                                                                                              (Term.add
                                                                                                                (Term.or
                                                                                                                  (Term.var
                                                                                                                    0)
                                                                                                                  (Term.and
                                                                                                                    (Term.var
                                                                                                                      1)
                                                                                                                    (Term.var
                                                                                                                      2)))
                                                                                                                (Term.add
                                                                                                                  (Term.shiftL
                                                                                                                    (Term.or
                                                                                                                      (Term.var
                                                                                                                        0)
                                                                                                                      (Term.and
                                                                                                                        (Term.var
                                                                                                                          1)
                                                                                                                        (Term.var
                                                                                                                          2)))
                                                                                                                    1)
                                                                                                                  (Term.shiftL
                                                                                                                    (Term.shiftL
                                                                                                                      (Term.or
                                                                                                                        (Term.var
                                                                                                                          0)
                                                                                                                        (Term.and
                                                                                                                          (Term.var
                                                                                                                            1)
                                                                                                                          (Term.var
                                                                                                                            2)))
                                                                                                                      1)
                                                                                                                    1))))
                                                                                                            (Term.and
                                                                                                              (Term.not
                                                                                                                (Term.var
                                                                                                                  1))
                                                                                                              (Term.or
                                                                                                                (Term.var
                                                                                                                  2)
                                                                                                                (Term.var
                                                                                                                  0))))
                                                                                                          (Term.or
                                                                                                            (Term.not
                                                                                                              (Term.or
                                                                                                                (Term.var
                                                                                                                  1)
                                                                                                                (Term.var
                                                                                                                  2)))
                                                                                                            (Term.xor
                                                                                                              (Term.var
                                                                                                                1)
                                                                                                              (Term.xor
                                                                                                                (Term.var
                                                                                                                  2)
                                                                                                                (Term.var
                                                                                                                  0)))))
                                                                                                        (Term.add
                                                                                                          (Term.xor
                                                                                                            (Term.var 2)
                                                                                                            (Term.not
                                                                                                              (Term.and
                                                                                                                (Term.not
                                                                                                                  (Term.var
                                                                                                                    1))
                                                                                                                (Term.xor
                                                                                                                  (Term.var
                                                                                                                    2)
                                                                                                                  (Term.var
                                                                                                                    0)))))
                                                                                                          (Term.add
                                                                                                            (Term.shiftL
                                                                                                              (Term.xor
                                                                                                                (Term.var
                                                                                                                  2)
                                                                                                                (Term.not
                                                                                                                  (Term.and
                                                                                                                    (Term.not
                                                                                                                      (Term.var
                                                                                                                        1))
                                                                                                                    (Term.xor
                                                                                                                      (Term.var
                                                                                                                        2)
                                                                                                                      (Term.var
                                                                                                                        0)))))
                                                                                                              1)
                                                                                                            (Term.shiftL
                                                                                                              (Term.shiftL
                                                                                                                (Term.xor
                                                                                                                  (Term.var
                                                                                                                    2)
                                                                                                                  (Term.not
                                                                                                                    (Term.and
                                                                                                                      (Term.not
                                                                                                                        (Term.var
                                                                                                                          1))
                                                                                                                      (Term.xor
                                                                                                                        (Term.var
                                                                                                                          2)
                                                                                                                        (Term.var
                                                                                                                          0)))))
                                                                                                                1)
                                                                                                              1))))
                                                                                                      (Term.and
                                                                                                        (Term.or
                                                                                                          (Term.var 1)
                                                                                                          (Term.not
                                                                                                            (Term.var
                                                                                                              2)))
                                                                                                        (Term.xor
                                                                                                          (Term.var 1)
                                                                                                          (Term.xor
                                                                                                            (Term.var 2)
                                                                                                            (Term.var
                                                                                                              0)))))
                                                                                                    (Term.add
                                                                                                      (Term.not
                                                                                                        (Term.or
                                                                                                          (Term.var 1)
                                                                                                          (Term.xor
                                                                                                            (Term.var 2)
                                                                                                            (Term.var
                                                                                                              0))))
                                                                                                      (Term.add
                                                                                                        (Term.shiftL
                                                                                                          (Term.not
                                                                                                            (Term.or
                                                                                                              (Term.var
                                                                                                                1)
                                                                                                              (Term.xor
                                                                                                                (Term.var
                                                                                                                  2)
                                                                                                                (Term.var
                                                                                                                  0))))
                                                                                                          1)
                                                                                                        (Term.shiftL
                                                                                                          (Term.shiftL
                                                                                                            (Term.shiftL
                                                                                                              (Term.not
                                                                                                                (Term.or
                                                                                                                  (Term.var
                                                                                                                    1)
                                                                                                                  (Term.xor
                                                                                                                    (Term.var
                                                                                                                      2)
                                                                                                                    (Term.var
                                                                                                                      0))))
                                                                                                              1)
                                                                                                            1)
                                                                                                          1))))
                                                                                                  (Term.shiftL
                                                                                                    (Term.shiftL
                                                                                                      (Term.xor
                                                                                                        (Term.var 2)
                                                                                                        (Term.and
                                                                                                          (Term.var 1)
                                                                                                          (Term.xor
                                                                                                            (Term.var 2)
                                                                                                            (Term.var
                                                                                                              0))))
                                                                                                      1)
                                                                                                    1))
                                                                                                (Term.or
                                                                                                  (Term.not
                                                                                                    (Term.var 1))
                                                                                                  (Term.or
                                                                                                    (Term.not
                                                                                                      (Term.var 2))
                                                                                                    (Term.var 0))))
                                                                                              (Term.add
                                                                                                (Term.or
                                                                                                  (Term.and
                                                                                                    (Term.var 1)
                                                                                                    (Term.not
                                                                                                      (Term.var 2)))
                                                                                                  (Term.not
                                                                                                    (Term.xor
                                                                                                      (Term.var 1)
                                                                                                      (Term.xor
                                                                                                        (Term.var 2)
                                                                                                        (Term.var 0)))))
                                                                                                (Term.shiftL
                                                                                                  (Term.shiftL
                                                                                                    (Term.or
                                                                                                      (Term.and
                                                                                                        (Term.var 1)
                                                                                                        (Term.not
                                                                                                          (Term.var 2)))
                                                                                                      (Term.not
                                                                                                        (Term.xor
                                                                                                          (Term.var 1)
                                                                                                          (Term.xor
                                                                                                            (Term.var 2)
                                                                                                            (Term.var
                                                                                                              0)))))
                                                                                                    1)
                                                                                                  1)))
                                                                                            (Term.add
                                                                                              (Term.xor
                                                                                                (Term.var 2)
                                                                                                (Term.or
                                                                                                  (Term.not
                                                                                                    (Term.var 1))
                                                                                                  (Term.xor
                                                                                                    (Term.var 2)
                                                                                                    (Term.var 0))))
                                                                                              (Term.add
                                                                                                (Term.shiftL
                                                                                                  (Term.xor
                                                                                                    (Term.var 2)
                                                                                                    (Term.or
                                                                                                      (Term.not
                                                                                                        (Term.var 1))
                                                                                                      (Term.xor
                                                                                                        (Term.var 2)
                                                                                                        (Term.var 0))))
                                                                                                  1)
                                                                                                (Term.shiftL
                                                                                                  (Term.shiftL
                                                                                                    (Term.shiftL
                                                                                                      (Term.xor
                                                                                                        (Term.var 2)
                                                                                                        (Term.or
                                                                                                          (Term.not
                                                                                                            (Term.var
                                                                                                              1))
                                                                                                          (Term.xor
                                                                                                            (Term.var 2)
                                                                                                            (Term.var
                                                                                                              0))))
                                                                                                      1)
                                                                                                    1)
                                                                                                  1))))
                                                                                          (Term.and
                                                                                            (Term.var 1)
                                                                                            (Term.or
                                                                                              (Term.var 2)
                                                                                              (Term.var 0))))
                                                                                        (Term.xor
                                                                                          (Term.var 0)
                                                                                          (Term.not
                                                                                            (Term.or
                                                                                              (Term.not (Term.var 1))
                                                                                              (Term.and
                                                                                                (Term.not (Term.var 2))
                                                                                                (Term.var 0))))))
                                                                                      (Term.add
                                                                                        (Term.xor
                                                                                          (Term.var 2)
                                                                                          (Term.and
                                                                                            (Term.not (Term.var 1))
                                                                                            (Term.or
                                                                                              (Term.var 2)
                                                                                              (Term.var 0))))
                                                                                        (Term.shiftL
                                                                                          (Term.xor
                                                                                            (Term.var 2)
                                                                                            (Term.and
                                                                                              (Term.not (Term.var 1))
                                                                                              (Term.or
                                                                                                (Term.var 2)
                                                                                                (Term.var 0))))
                                                                                          1)))
                                                                                    (Term.add
                                                                                      (Term.xor
                                                                                        (Term.var 2)
                                                                                        (Term.and
                                                                                          (Term.var 1)
                                                                                          (Term.not (Term.var 0))))
                                                                                      (Term.add
                                                                                        (Term.shiftL
                                                                                          (Term.xor
                                                                                            (Term.var 2)
                                                                                            (Term.and
                                                                                              (Term.var 1)
                                                                                              (Term.not (Term.var 0))))
                                                                                          1)
                                                                                        (Term.shiftL
                                                                                          (Term.shiftL
                                                                                            (Term.xor
                                                                                              (Term.var 2)
                                                                                              (Term.and
                                                                                                (Term.var 1)
                                                                                                (Term.not
                                                                                                  (Term.var 0))))
                                                                                            1)
                                                                                          1))))
                                                                                  (Term.not
                                                                                    (Term.and
                                                                                      (Term.not (Term.var 1))
                                                                                      (Term.and
                                                                                        (Term.not (Term.var 2))
                                                                                        (Term.var 0)))))
                                                                                (Term.xor
                                                                                  (Term.var 2)
                                                                                  (Term.or
                                                                                    (Term.var 1)
                                                                                    (Term.and
                                                                                      (Term.var 2)
                                                                                      (Term.var 0)))))
                                                                              (Term.xor
                                                                                (Term.var 2)
                                                                                (Term.and
                                                                                  (Term.var 1)
                                                                                  (Term.or
                                                                                    (Term.not (Term.var 2))
                                                                                    (Term.var 0)))))
                                                                            (Term.xor
                                                                              (Term.var 0)
                                                                              (Term.and
                                                                                (Term.not (Term.var 1))
                                                                                (Term.or
                                                                                  (Term.not (Term.var 2))
                                                                                  (Term.var 0)))))
                                                                          (Term.or
                                                                            (Term.var 1)
                                                                            (Term.and
                                                                              (Term.not (Term.var 2))
                                                                              (Term.var 0))))
                                                                        (Term.add
                                                                          (Term.shiftL
                                                                            (Term.xor
                                                                              (Term.var 2)
                                                                              (Term.not
                                                                                (Term.or
                                                                                  (Term.var 1)
                                                                                  (Term.not (Term.var 0)))))
                                                                            1)
                                                                          (Term.shiftL
                                                                            (Term.shiftL
                                                                              (Term.xor
                                                                                (Term.var 2)
                                                                                (Term.not
                                                                                  (Term.or
                                                                                    (Term.var 1)
                                                                                    (Term.not (Term.var 0)))))
                                                                              1)
                                                                            1)))
                                                                      (Term.add
                                                                        (Term.not (Term.or (Term.var 1) (Term.var 0)))
                                                                        (Term.shiftL
                                                                          (Term.not (Term.or (Term.var 1) (Term.var 0)))
                                                                          1)))
                                                                    (Term.shiftL
                                                                      (Term.shiftL
                                                                        (Term.or
                                                                          (Term.var 2)
                                                                          (Term.not
                                                                            (Term.xor (Term.var 1) (Term.var 0))))
                                                                        1)
                                                                      1))
                                                                  (Term.add
                                                                    (Term.not
                                                                      (Term.and
                                                                        (Term.var 1)
                                                                        (Term.or (Term.not (Term.var 2)) (Term.var 0))))
                                                                    (Term.not
                                                                      (Term.and
                                                                        (Term.var 1)
                                                                        (Term.or
                                                                          (Term.not (Term.var 2))
                                                                          (Term.var 0))))))
                                                                (Term.add
                                                                  (Term.shiftL (Term.var 0) 1)
                                                                  (Term.shiftL (Term.shiftL (Term.var 0) 1) 1)))
                                                              (Term.or
                                                                (Term.var 2)
                                                                (Term.not
                                                                  (Term.or (Term.var 1) (Term.not (Term.var 0))))))
                                                            (Term.add
                                                              (Term.or
                                                                (Term.xor (Term.var 1) (Term.var 2))
                                                                (Term.not (Term.xor (Term.var 1) (Term.var 0))))
                                                              (Term.shiftL
                                                                (Term.shiftL
                                                                  (Term.or
                                                                    (Term.xor (Term.var 1) (Term.var 2))
                                                                    (Term.not (Term.xor (Term.var 1) (Term.var 0))))
                                                                  1)
                                                                1)))
                                                          (Term.add
                                                            (Term.xor
                                                              (Term.var 0)
                                                              (Term.or
                                                                (Term.not (Term.var 1))
                                                                (Term.or (Term.var 2) (Term.var 0))))
                                                            (Term.xor
                                                              (Term.var 0)
                                                              (Term.or
                                                                (Term.not (Term.var 1))
                                                                (Term.or (Term.var 2) (Term.var 0))))))
                                                        (Term.add
                                                          (Term.xor
                                                            (Term.var 0)
                                                            (Term.not (Term.or (Term.var 1) (Term.not (Term.var 2)))))
                                                          (Term.shiftL
                                                            (Term.shiftL
                                                              (Term.xor
                                                                (Term.var 0)
                                                                (Term.not
                                                                  (Term.or (Term.var 1) (Term.not (Term.var 2)))))
                                                              1)
                                                            1)))
                                                      (Term.add
                                                        (Term.or
                                                          (Term.var 2)
                                                          (Term.and (Term.var 1) (Term.not (Term.var 0))))
                                                        (Term.add
                                                          (Term.shiftL
                                                            (Term.or
                                                              (Term.var 2)
                                                              (Term.and (Term.var 1) (Term.not (Term.var 0))))
                                                            1)
                                                          (Term.shiftL
                                                            (Term.shiftL
                                                              (Term.shiftL
                                                                (Term.or
                                                                  (Term.var 2)
                                                                  (Term.and (Term.var 1) (Term.not (Term.var 0))))
                                                                1)
                                                              1)
                                                            1))))
                                                    (Term.add
                                                      (Term.not
                                                        (Term.and (Term.var 1) (Term.and (Term.var 2) (Term.var 0))))
                                                      (Term.add
                                                        (Term.shiftL
                                                          (Term.not
                                                            (Term.and
                                                              (Term.var 1)
                                                              (Term.and (Term.var 2) (Term.var 0))))
                                                          1)
                                                        (Term.shiftL
                                                          (Term.shiftL
                                                            (Term.shiftL
                                                              (Term.not
                                                                (Term.and
                                                                  (Term.var 1)
                                                                  (Term.and (Term.var 2) (Term.var 0))))
                                                              1)
                                                            1)
                                                          1))))
                                                  (Term.add
                                                    (Term.xor
                                                      (Term.var 2)
                                                      (Term.not
                                                        (Term.and
                                                          (Term.not (Term.var 1))
                                                          (Term.or (Term.not (Term.var 2)) (Term.var 0)))))
                                                    (Term.shiftL
                                                      (Term.xor
                                                        (Term.var 2)
                                                        (Term.not
                                                          (Term.and
                                                            (Term.not (Term.var 1))
                                                            (Term.or (Term.not (Term.var 2)) (Term.var 0)))))
                                                      1)))
                                                (Term.add
                                                  (Term.or
                                                    (Term.and (Term.var 1) (Term.var 2))
                                                    (Term.xor (Term.var 2) (Term.var 0)))
                                                  (Term.shiftL
                                                    (Term.shiftL
                                                      (Term.or
                                                        (Term.and (Term.var 1) (Term.var 2))
                                                        (Term.xor (Term.var 2) (Term.var 0)))
                                                      1)
                                                    1)))
                                              (Term.xor
                                                (Term.and (Term.var 2) (Term.not (Term.var 0)))
                                                (Term.or (Term.not (Term.var 1)) (Term.xor (Term.var 2) (Term.var 0)))))
                                            (Term.add
                                              (Term.xor
                                                (Term.var 0)
                                                (Term.not
                                                  (Term.and
                                                    (Term.var 1)
                                                    (Term.and (Term.not (Term.var 2)) (Term.var 0)))))
                                              (Term.shiftL
                                                (Term.xor
                                                  (Term.var 0)
                                                  (Term.not
                                                    (Term.and
                                                      (Term.var 1)
                                                      (Term.and (Term.not (Term.var 2)) (Term.var 0)))))
                                                1)))
                                          (Term.not
                                            (Term.and (Term.var 1) (Term.and (Term.not (Term.var 2)) (Term.var 0)))))
                                        (Term.shiftL
                                          (Term.shiftL
                                            (Term.not
                                              (Term.and (Term.not (Term.var 1)) (Term.and (Term.var 2) (Term.var 0))))
                                            1)
                                          1))
                                      (Term.add
                                        (Term.shiftL
                                          (Term.and
                                            (Term.or (Term.var 1) (Term.var 2))
                                            (Term.not (Term.xor (Term.var 2) (Term.var 0))))
                                          1)
                                        (Term.shiftL
                                          (Term.shiftL
                                            (Term.and
                                              (Term.or (Term.var 1) (Term.var 2))
                                              (Term.not (Term.xor (Term.var 2) (Term.var 0))))
                                            1)
                                          1)))
                                    (Term.add
                                      (Term.and (Term.not (Term.var 2)) (Term.xor (Term.var 1) (Term.var 0)))
                                      (Term.add
                                        (Term.shiftL
                                          (Term.and (Term.not (Term.var 2)) (Term.xor (Term.var 1) (Term.var 0)))
                                          1)
                                        (Term.shiftL
                                          (Term.shiftL
                                            (Term.shiftL
                                              (Term.and (Term.not (Term.var 2)) (Term.xor (Term.var 1) (Term.var 0)))
                                              1)
                                            1)
                                          1))))
                                  (Term.add
                                    (Term.and (Term.var 0) (Term.or (Term.var 1) (Term.not (Term.var 2))))
                                    (Term.add
                                      (Term.shiftL
                                        (Term.and (Term.var 0) (Term.or (Term.var 1) (Term.not (Term.var 2))))
                                        1)
                                      (Term.shiftL
                                        (Term.shiftL
                                          (Term.and (Term.var 0) (Term.or (Term.var 1) (Term.not (Term.var 2))))
                                          1)
                                        1))))
                                (Term.add
                                  (Term.and (Term.var 1) (Term.or (Term.not (Term.var 2)) (Term.var 0)))
                                  (Term.shiftL
                                    (Term.shiftL
                                      (Term.and (Term.var 1) (Term.or (Term.not (Term.var 2)) (Term.var 0)))
                                      1)
                                    1)))
                              (Term.add
                                (Term.not (Term.or (Term.var 2) (Term.var 0)))
                                (Term.add
                                  (Term.shiftL (Term.not (Term.or (Term.var 2) (Term.var 0))) 1)
                                  (Term.shiftL
                                    (Term.shiftL (Term.shiftL (Term.not (Term.or (Term.var 2) (Term.var 0))) 1) 1)
                                    1))))
                            (Term.add
                              (Term.xor (Term.var 0) (Term.not (Term.and (Term.var 1) (Term.var 2))))
                              (Term.add
                                (Term.shiftL (Term.xor (Term.var 0) (Term.not (Term.and (Term.var 1) (Term.var 2)))) 1)
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.xor (Term.var 0) (Term.not (Term.and (Term.var 1) (Term.var 2))))
                                    1)
                                  1))))
                          (Term.and (Term.xor (Term.var 1) (Term.var 2)) (Term.xor (Term.var 1) (Term.var 0))))
                        (Term.add
                          (Term.not (Term.or (Term.var 1) (Term.or (Term.var 2) (Term.var 0))))
                          (Term.add
                            (Term.shiftL (Term.not (Term.or (Term.var 1) (Term.or (Term.var 2) (Term.var 0)))) 1)
                            (Term.add
                              (Term.shiftL
                                (Term.shiftL (Term.not (Term.or (Term.var 1) (Term.or (Term.var 2) (Term.var 0)))) 1)
                                1)
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.shiftL
                                      (Term.shiftL
                                        (Term.not (Term.or (Term.var 1) (Term.or (Term.var 2) (Term.var 0))))
                                        1)
                                      1)
                                    1)
                                  1)
                                1)))))
                      (Term.add
                        (Term.not (Term.or (Term.var 1) (Term.or (Term.not (Term.var 2)) (Term.var 0))))
                        (Term.add
                          (Term.shiftL
                            (Term.shiftL
                              (Term.not (Term.or (Term.var 1) (Term.or (Term.not (Term.var 2)) (Term.var 0))))
                              1)
                            1)
                          (Term.add
                            (Term.shiftL
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.not (Term.or (Term.var 1) (Term.or (Term.not (Term.var 2)) (Term.var 0))))
                                  1)
                                1)
                              1)
                            (Term.shiftL
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.not (Term.or (Term.var 1) (Term.or (Term.not (Term.var 2)) (Term.var 0))))
                                    1)
                                  1)
                                1)
                              1)))))
                    (Term.add
                      (Term.shiftL (Term.not (Term.or (Term.not (Term.var 1)) (Term.or (Term.var 2) (Term.var 0)))) 1)
                      (Term.add
                        (Term.shiftL
                          (Term.shiftL
                            (Term.not (Term.or (Term.not (Term.var 1)) (Term.or (Term.var 2) (Term.var 0))))
                            1)
                          1)
                        (Term.add
                          (Term.shiftL
                            (Term.shiftL
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.not (Term.or (Term.not (Term.var 1)) (Term.or (Term.var 2) (Term.var 0))))
                                  1)
                                1)
                              1)
                            1)
                          (Term.shiftL
                            (Term.shiftL
                              (Term.shiftL
                                (Term.shiftL
                                  (Term.shiftL
                                    (Term.not (Term.or (Term.not (Term.var 1)) (Term.or (Term.var 2) (Term.var 0))))
                                    1)
                                  1)
                                1)
                              1)
                            1)))))
                  (Term.shiftL
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL
                          (Term.shiftL
                            (Term.not (Term.or (Term.not (Term.var 1)) (Term.or (Term.not (Term.var 2)) (Term.var 0))))
                            1)
                          1)
                        1)
                      1)
                    1))
                (Term.add
                  (Term.and (Term.not (Term.var 1)) (Term.and (Term.not (Term.var 2)) (Term.var 0)))
                  (Term.add
                    (Term.shiftL (Term.and (Term.not (Term.var 1)) (Term.and (Term.not (Term.var 2)) (Term.var 0))) 1)
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL
                          (Term.shiftL
                            (Term.and (Term.not (Term.var 1)) (Term.and (Term.not (Term.var 2)) (Term.var 0)))
                            1)
                          1)
                        1)
                      1))))
              (Term.add
                (Term.shiftL (Term.shiftL (Term.and (Term.not (Term.var 1)) (Term.and (Term.var 2) (Term.var 0))) 1) 1)
                (Term.add
                  (Term.shiftL
                    (Term.shiftL
                      (Term.shiftL (Term.and (Term.not (Term.var 1)) (Term.and (Term.var 2) (Term.var 0))) 1)
                      1)
                    1)
                  (Term.add
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL
                          (Term.shiftL (Term.and (Term.not (Term.var 1)) (Term.and (Term.var 2) (Term.var 0))) 1)
                          1)
                        1)
                      1)
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL
                          (Term.shiftL
                            (Term.shiftL (Term.and (Term.not (Term.var 1)) (Term.and (Term.var 2) (Term.var 0))) 1)
                            1)
                          1)
                        1)
                      1)))))
            (Term.add
              (Term.and (Term.var 1) (Term.and (Term.not (Term.var 2)) (Term.var 0)))
              (Term.add
                (Term.shiftL (Term.and (Term.var 1) (Term.and (Term.not (Term.var 2)) (Term.var 0))) 1)
                (Term.add
                  (Term.shiftL
                    (Term.shiftL (Term.and (Term.var 1) (Term.and (Term.not (Term.var 2)) (Term.var 0))) 1)
                    1)
                  (Term.add
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL (Term.and (Term.var 1) (Term.and (Term.not (Term.var 2)) (Term.var 0))) 1)
                        1)
                      1)
                    (Term.shiftL
                      (Term.shiftL
                        (Term.shiftL
                          (Term.shiftL (Term.and (Term.var 1) (Term.and (Term.not (Term.var 2)) (Term.var 0))) 1)
                          1)
                        1)
                      1))))))
          (Term.add
            (Term.and (Term.var 1) (Term.and (Term.var 2) (Term.var 0)))
            (Term.shiftL
              (Term.shiftL
                (Term.shiftL
                  (Term.shiftL (Term.shiftL (Term.and (Term.var 1) (Term.and (Term.var 2) (Term.var 0))) 1) 1)
                  1)
                1)
              1)))
        (Term.add
          (Term.neg
            (Term.xor
              (Term.var 2)
              (Term.not (Term.or (Term.not (Term.var 1)) (Term.and (Term.not (Term.var 2)) (Term.var 0))))))
          (Term.add
            (Term.not (Term.xor (Term.var 1) (Term.var 0)))
            (Term.shiftL (Term.not (Term.xor (Term.var 1) (Term.var 0))) 1)))
]
