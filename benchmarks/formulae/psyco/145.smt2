(set-info :smt-lib-version 2.6)
(set-logic LIA)
(set-info
  :source |
 Generated by PSyCO 0.1
 More info in N. P. Lopes and J. Monteiro. Weakest Precondition Synthesis for
 Compiler Optimizations, VMCAI'14.
|)
(set-info :category "industrial")
(set-info :status sat)
(declare-fun W_S1_V4 () Bool)
(declare-fun W_S1_V1 () Bool)
(declare-fun R_E1_V4 () Bool)
(declare-fun R_E1_V2 () Bool)
(declare-fun R_E1_V3 () Bool)
(declare-fun R_S1_V4 () Bool)
(declare-fun R_S1_V2 () Bool)
(declare-fun R_S1_V3 () Bool)
(declare-fun R_S1_V1 () Bool)
(declare-fun DISJ_W_S1_R_E1 () Bool)
(declare-fun DISJ_W_S1_R_S1 () Bool)
(declare-fun W_S1_V3 () Bool)
(declare-fun W_S1_V2 () Bool)
(declare-fun R_E1_V1 () Bool)
(assert
 (let
 (($x1318
   (forall
    ((V3_0 Int) (V2_0 Int) 
     (V4_0 Int) (MW_S1_V1 Bool) 
     (MW_S1_V3 Bool) (MW_S1_V2 Bool) 
     (MW_S1_V4 Bool) (S1_V3_!438 Int) 
     (S1_V3_!444 Int) (S1_V3_!449 Int) 
     (S1_V4_!440 Int) (S1_V4_!446 Int) 
     (S1_V4_!451 Int) (S1_V1_!437 Int) 
     (S1_V1_!443 Int) (S1_V1_!448 Int) 
     (S1_V2_!439 Int) (S1_V2_!445 Int) 
     (S1_V2_!450 Int) (E1_!436 Int) 
     (E1_!441 Int) (E1_!442 Int) 
     (E1_!447 Int) (E1_!452 Int))
    (let
    (($x1112
      (and
      (= (ite MW_S1_V1 S1_V1_!437 E1_!436)
      (+ (- 1) (ite MW_S1_V2 S1_V2_!450 V2_0)))
      (= (ite MW_S1_V3 S1_V3_!438 V3_0) (ite MW_S1_V3 S1_V3_!449 V3_0))
      (= (ite MW_S1_V2 S1_V2_!439 V2_0) (ite MW_S1_V2 S1_V2_!450 V2_0))
      (= (ite MW_S1_V4 S1_V4_!440 V4_0) (ite MW_S1_V4 S1_V4_!451 V4_0)))))
    (let
    (($x1126
      (<= E1_!452
      (+ (- 1)
      (ite MW_S1_V1 S1_V1_!448
      (+ (- 1) (ite MW_S1_V1 S1_V1_!443 (+ (- 1) V2_0))))))))
    (let
    (($x848
      (and (not (<= V2_0 E1_!436))
      (>= (ite MW_S1_V1 S1_V1_!437 E1_!436)
      (+ (- 1) (ite MW_S1_V2 S1_V2_!439 V2_0))) 
      (not (<= V2_0 E1_!441)) 
      (>= V2_0 (+ 1 E1_!442))
      (>= (ite MW_S1_V1 S1_V1_!443 (+ (- 1) V2_0)) (+ 1 E1_!447))
      (not $x1126))))
    (let
    (($x1309
      (and
      (or (not R_E1_V3)
      (= (ite MW_S1_V3 S1_V3_!449 V3_0) (ite MW_S1_V3 S1_V3_!444 V3_0)))
      (or (not R_E1_V2)
      (= (ite MW_S1_V2 S1_V2_!450 V2_0) (ite MW_S1_V2 S1_V2_!445 V2_0)))
      (or (not R_E1_V4)
      (= (ite MW_S1_V4 S1_V4_!451 V4_0) (ite MW_S1_V4 S1_V4_!446 V4_0))))))
    (let
    (($x910
      (and (or (not R_E1_V3) (= (ite MW_S1_V3 S1_V3_!449 V3_0) V3_0))
      (or (not R_E1_V2) (= (ite MW_S1_V2 S1_V2_!450 V2_0) V2_0))
      (or (not R_E1_V4) (= (ite MW_S1_V4 S1_V4_!451 V4_0) V4_0)))))
    (let (($x824 (not $x910)))
    (let
    (($x1041
      (and (or (not R_E1_V3) (= (ite MW_S1_V3 S1_V3_!444 V3_0) V3_0))
      (or (not R_E1_V2) (= (ite MW_S1_V2 S1_V2_!445 V2_0) V2_0))
      (or (not R_E1_V4) (= (ite MW_S1_V4 S1_V4_!446 V4_0) V4_0)))))
    (let
    (($x829
      (and (or (not R_E1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!444 V3_0)))
      (or (not R_E1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!445 V2_0)))
      (or (not R_E1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!446 V4_0))))))
    (let
    (($x600
      (and
      (or (not R_S1_V1) (= (ite MW_S1_V1 S1_V1_!443 (+ (- 1) V2_0)) V2_0))
      (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!444 V3_0) V3_0))
      (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!445 V2_0) V2_0))
      (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!446 V4_0) V4_0)))))
    (let (($x102 (not R_S1_V1)))
    (let
    (($x1210
      (and
      (or $x102
      (= E1_!436 (+ (- 1) (ite MW_S1_V1 S1_V1_!443 (+ (- 1) V2_0)))))
      (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!444 V3_0)))
      (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!445 V2_0)))
      (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!446 V4_0))))))
    (let (($x1174 (not $x1210)))
    (let
    (($x1319
      (and
      (or $x102 (= (ite MW_S1_V1 S1_V1_!443 (+ (- 1) V2_0)) (+ 1 E1_!436)))
      (or (not R_S1_V3) (= (ite MW_S1_V3 S1_V3_!444 V3_0) V3_0))
      (or (not R_S1_V2) (= (ite MW_S1_V2 S1_V2_!445 V2_0) V2_0))
      (or (not R_S1_V4) (= (ite MW_S1_V4 S1_V4_!446 V4_0) V4_0)))))
    (let
    (($x1372
      (and (or $x102 (= V2_0 (ite MW_S1_V1 S1_V1_!443 (+ (- 1) V2_0))))
      (or (not R_S1_V3) (= V3_0 (ite MW_S1_V3 S1_V3_!444 V3_0)))
      (or (not R_S1_V2) (= V2_0 (ite MW_S1_V2 S1_V2_!445 V2_0)))
      (or (not R_S1_V4) (= V4_0 (ite MW_S1_V4 S1_V4_!446 V4_0))))))
    (let
    (($x915
      (and
      (or (not (or $x102 (= E1_!436 (+ (- 1) V2_0))))
      (= S1_V3_!438 S1_V3_!444)) 
      (or $x1174 (= S1_V3_!438 S1_V3_!449))
      (or (not $x1372) (= S1_V3_!444 S1_V3_!449))
      (or (not (or $x102 (= V2_0 (+ 1 E1_!436)))) (= S1_V4_!446 S1_V4_!440))
      (or (not $x1372) (= S1_V4_!446 S1_V4_!451))
      (or (not $x1319) (= S1_V4_!451 S1_V4_!440))
      (or (not (or $x102 (= E1_!436 (+ (- 1) V2_0))))
      (= S1_V1_!437 S1_V1_!443)) 
      (or $x1174 (= S1_V1_!437 S1_V1_!448))
      (or (not $x600) (= S1_V1_!448 S1_V1_!443))
      (or (not (or $x102 (= E1_!436 (+ (- 1) V2_0))))
      (= S1_V2_!439 S1_V2_!445)) 
      (or $x1174 (= S1_V2_!439 S1_V2_!450))
      (or (not $x600) (= S1_V2_!450 S1_V2_!445)) 
      (= E1_!436 E1_!442) 
      (or (not $x829) (= E1_!436 E1_!447)) 
      (= E1_!441 E1_!436) 
      (= E1_!441 E1_!442) 
      (or (not $x829) (= E1_!441 E1_!447))
      (or (not $x1041) (= E1_!447 E1_!442)) 
      (or $x824 (= E1_!452 E1_!436)) 
      (or $x824 (= E1_!452 E1_!441)) 
      (or $x824 (= E1_!452 E1_!442)) 
      (or (not $x1309) (= E1_!452 E1_!447)) 
      (or (not MW_S1_V1) W_S1_V1) 
      (not MW_S1_V2) (or (not MW_S1_V4) W_S1_V4))))
    (or (not $x915) (not $x848) $x1112)))))))))))))))))))
 (let
 (($x555 (not (or (and W_S1_V1 R_S1_V1) R_S1_V3 (and W_S1_V4 R_S1_V4)))))
 (let (($x518 (not W_S1_V1)))
 (let
 (($x896
   (or (and DISJ_W_S1_R_S1 DISJ_W_S1_R_E1) $x518
   (and (not R_S1_V1) DISJ_W_S1_R_E1))))
 (let (($x522 (not W_S1_V2)))
 (let (($x70 (not R_E1_V1)))
 (and $x70 $x522 $x896 W_S1_V3 
 (= DISJ_W_S1_R_S1 $x555)
 (= DISJ_W_S1_R_E1 (not (or R_E1_V3 (and W_S1_V4 R_E1_V4)))) $x1318))))))))
(check-sat)
(exit)
