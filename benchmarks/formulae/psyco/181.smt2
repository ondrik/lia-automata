(set-info :smt-lib-version 2.6)
(set-logic LIA)
(set-info
  :source |
 Generated by PSyCO 0.1
 More info in N. P. Lopes and J. Monteiro. Weakest Precondition Synthesis for
 Compiler Optimizations, VMCAI'14.
|)
(set-info :category "industrial")
(set-info :status unsat)
(declare-fun W_S1_V2 () Bool)
(declare-fun W_S1_V5 () Bool)
(declare-fun R_S1_V2 () Bool)
(declare-fun R_S1_V5 () Bool)
(declare-fun R_S1_V4 () Bool)
(declare-fun DISJ_W_S1_R_S1 () Bool)
(declare-fun W_S1_V4 () Bool)
(declare-fun R_S1_V1 () Bool)
(declare-fun W_S1_V1 () Bool)
(assert
 (let
 (($x982
   (forall
    ((V4_0 Int) (V5_0 Int) 
     (V2_0 Int) (MW_S1_V4 Bool) 
     (MW_S1_V5 Bool) (MW_S1_V2 Bool) 
     (MW_S1_V1 Bool) (S1_V4_!380 Int) 
     (S1_V4_!384 Int) (S1_V1_!383 Int) 
     (S1_V1_!387 Int) (S1_V2_!382 Int) 
     (S1_V2_!386 Int) (S1_V5_!381 Int) 
     (S1_V5_!385 Int))
    (let ((?x1076 (ite MW_S1_V1 S1_V1_!383 0)))
    (let (($x668 (= ?x1076 (- 1))))
    (let ((?x914 (ite MW_S1_V2 S1_V2_!386 V2_0)))
    (let ((?x996 (ite MW_S1_V2 S1_V2_!382 V2_0)))
    (let (($x1083 (= ?x996 ?x914)))
    (let ((?x626 (ite MW_S1_V5 S1_V5_!385 V5_0)))
    (let ((?x746 (ite MW_S1_V5 S1_V5_!381 V5_0)))
    (let (($x1001 (= ?x746 ?x626)))
    (let ((?x1297 (ite MW_S1_V4 S1_V4_!384 V4_0)))
    (let ((?x811 (ite MW_S1_V4 S1_V4_!380 V4_0)))
    (let (($x619 (= ?x811 ?x1297)))
    (let (($x998 (and $x619 $x1001 $x1083 $x668)))
    (let (($x589 (<= ?x914 0)))
    (let (($x1256 (<= 2 V2_0)))
    (let (($x946 (not $x1256)))
    (let (($x528 (>= V2_0 1)))
    (let ((?x1087 (+ (- 1) ?x996)))
    (let (($x1012 (>= ?x1076 ?x1087)))
    (let (($x1004 (<= V2_0 0)))
    (let (($x1210 (not $x1004)))
    (let (($x617 (and $x1210 $x1012 $x528 $x946 $x589)))
    (let (($x553 (not $x617)))
    (let (($x531 (not MW_S1_V1)))
    (let (($x806 (not MW_S1_V2)))
    (let (($x643 (or $x806 W_S1_V2)))
    (let (($x663 (not MW_S1_V5)))
    (let (($x1126 (or $x663 W_S1_V5)))
    (let (($x1097 (= S1_V5_!385 S1_V5_!381)))
    (let (($x759 (= S1_V2_!382 S1_V2_!386)))
    (let (($x1074 (= S1_V1_!387 S1_V1_!383)))
    (let (($x801 (= S1_V4_!384 S1_V4_!380)))
    (let (($x1163 (and $x801 $x1074 $x759 $x1097 $x1126 $x643 $x531)))
    (let (($x915 (not $x1163))) (or $x915 $x553 $x998)))))))))))))))))))))))))))))))))))))
 (let (($x15 (and W_S1_V2 R_S1_V2)))
 (let (($x12 (and W_S1_V5 R_S1_V5)))
 (let (($x799 (or R_S1_V4 $x12 $x15)))
 (let (($x960 (not $x799)))
 (let (($x888 (= DISJ_W_S1_R_S1 $x960)))
 (let (($x82 (not R_S1_V1)))
 (let (($x782 (and $x82 DISJ_W_S1_R_S1)))
 (let (($x516 (not W_S1_V2)))
 (let (($x1278 (or $x516 $x782)))
 (let (($x522 (not W_S1_V1))) (and $x522 $x1278 W_S1_V4 $x888 $x982)))))))))))))
(assert W_S1_V2)
(check-sat)
(exit)
