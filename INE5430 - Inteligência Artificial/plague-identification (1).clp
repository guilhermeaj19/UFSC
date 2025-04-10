; Definicao de Planta

(deftemplate Planta 
	(slot folhas_amarelas)
	(slot folhas_enfraquecidas)
	(slot folhas_deformadas)
	(slot folhas_murchas) 
	(slot folhas_buracos) 
	(slot folhas_secas)
	(slot folhas_roidas) 
	(slot manchas_pegajosas)
	(slot manchas_negras)
	(slot manchas_varias_cores)
	(slot presenca_insetos)
	(slot presenca_teias)
	(slot presenca_moluscos)
	(slot presenca_crostas)
	(slot presenca_lagartas)
	(slot presenca_mofo)
	(slot presenca_fezes)
	(slot crescimento_afetado) 
	(slot frutos_danificados) 
	(slot cheiro_desgradavel) 
	(slot raizes_deformadas)
)

(deftemplate Praga
	(slot praga))

; PERGUNTAS
;==================================================
; FOLHAS
(defrule GetFolhasAmarelas
	(declare (salience 9))
   =>
   (printout t "Percebe-se amaralamento das folhas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_amarelas ?resposta))))

(defrule GetFolhasEnfraquecidas
	(declare (salience 9))
   =>
   (printout t "Percebe-se enfraquecimento das folhas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_enfraquecidas ?resposta))))

(defrule GetFolhasDeformadas
	(declare (salience 9))
   =>
   (printout t "Percebem-se deformidades nas folhas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_deformadas ?resposta))))

(defrule GetFolhasMurchas
	(declare (salience 9))
   =>
   (printout t "Percebem-se folhas murchas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_murchas ?resposta))))

(defrule GetFolhasBuracos
	(declare (salience 9))
   =>
   (printout t "Percebem-se buracos nas folhas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_buracos ?resposta))))

(defrule GetFolhasSecas
	(declare (salience 9))
   =>
   (printout t "Percebem-se folhas secas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_secas ?resposta))))

(defrule GetFolhasRoidas
	(declare (salience 9))
   =>
   (printout t "Percebem-se folhas roidas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (folhas_roidas ?resposta))))
;==================================================
; MANCHAS
(defrule GetManchasPegajosas
	(declare (salience 9))
   =>
   (printout t "Percebem-se manchas pegajosas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (manchas_pegajosas ?resposta))))

(defrule GetManchasNegras
	(declare (salience 9))
   =>
   (printout t "Percebem-se manchas negras? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (manchas_negras ?resposta))))

(defrule GetManchasVariasCores
	(declare (salience 9))
   =>
   (printout t "Percebem-se manchas de varias cores? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (manchas_varias_cores ?resposta))))
;==================================================
; PRESENCA
(defrule GetPresencaInsetos
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de insetos? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_insetos ?resposta))))

(defrule GetPresencaTeias
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de teias? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_teias ?resposta))))

(defrule GetPresencaMoluscos
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de moluscos? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_moluscos ?resposta))))

(defrule GetPresencaCrostas
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de crostas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_crostas ?resposta))))

(defrule GetPresencaLagartas
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de lagartas? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_lagartas ?resposta))))

(defrule GetPresencaMofo
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de mofo? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_mofo ?resposta))))

(defrule GetPresencaFezes
	(declare (salience 9))
   =>
   (printout t "Percebe-se a presenca de fezes? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (presenca_fezes ?resposta))))
;==================================================
; CRESCIMENTO AFETADO
(defrule GetCrescimentoAfetado
	(declare (salience 9))
   =>
   (printout t "Percebe-se que o crescimento da planta foi desacelarado? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (crescimento_afetado ?resposta))))
;==================================================
; FRUTOS DANIFICADOS
(defrule GetFrutosDanificados
	(declare (salience 9))
   =>
   (printout t "Percebe-se que os frutos foram danificados? Caso a planta nao tenha frutos, responda nao (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (frutos_danificados ?resposta))))
;==================================================
; CHEIRO DESAGRADAVEL
(defrule GetCheiroDesagradavel
	(declare (salience 9))
   =>
   (printout t "Percebe-se um cheiro desagradavel proxima a planta? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (cheiro_desgradavel ?resposta))))
;==================================================
; RAIZES DEFORMADAS
(defrule GetRaizesDeformadas
	(declare (salience 9))
   =>
   (printout t "Percebe-se uma deformacao nas raizes da planta? (sim/nao)")
   (bind ?resposta (read))
   (assert (Planta (raizes_deformadas ?resposta))))
;==================================================
; DEFINICAO DAS REGRAS DE INFERENCIA

; PULGAO
(defrule IsPulgao(and(Planta (folhas_amarelas sim))
					 (Planta (folhas_enfraquecidas sim))
					 (Planta (folhas_deformadas sim))
					 (Planta (manchas_pegajosas sim))
					 (Planta (presenca_insetos sim)))
	=>
	(assert (Praga (praga Pulgao)))
	(printout t "Praga identificada! Pulgoes sao a causa." crlf))

; ACARO
(defrule IsAcaro(and(Planta (folhas_amarelas sim))
			 		(Planta (folhas_murchas sim))
					(Planta (presenca_teias sim))
					(Planta (presenca_crostas sim))
					(Planta (crescimento_afetado sim)))
	=>
	(assert (Praga (praga Acaro)))
	(printout t "Praga identificada! Acaros sao a causa." crlf))

; MOSCA BRANCA
(defrule IsMoscaBranca(and(Planta (folhas_amarelas sim))
						  (Planta (folhas_murchas sim))
						  (Planta (manchas_negras sim))
						  (Planta (presenca_insetos sim)))
	=>
	(assert (Praga (praga MoscaBranca)))
	(printout t "Praga identificada! Moscas Brancas sao a causa." crlf))

; BROCA
(defrule IsBroca(and(Planta (folhas_amarelas sim))
			        (Planta (folhas_enfraquecidas sim))
			        (Planta (folhas_murchas sim))
			        (Planta (folhas_buracos sim))
			        (Planta (crescimento_afetado sim)))
	=>
	(assert (Praga (praga Broca)))
	(printout t "Praga identificada! Brocas sao a causa." crlf))

; LESMA E CARACOL
(defrule IsLesmaCaracol(and(Planta (folhas_enfraquecidas sim))
			               (Planta (folhas_murchas sim))
			               (Planta (folhas_buracos sim))
			               (Planta (presenca_moluscos sim)))
	=>
	(assert (Praga (praga LesmaCaracol)))
	(printout t "Praga identificada! Lesmas e Caracois sao a causa." crlf))

; LAGARTAS
(defrule IsLagarta(and(Planta (folhas_roidas sim))
			          (Planta (presenca_lagartas sim))
			          (Planta (presenca_fezes sim))
			          (Planta (frutos_danificados sim)))
	=>
	(assert (Praga (praga Lagarta)))
	(printout t "Praga identificada! Lagartas sao a causa." crlf))

; FUNGOS
(defrule IsFungo(and(Planta (folhas_deformadas sim))
			        (Planta (folhas_secas sim))
			        (Planta (manchas_varias_cores sim))
			        (Planta (presenca_mofo sim))
			        (Planta (crescimento_afetado sim))
			        (Planta (frutos_danificados sim))
			        (Planta (cheiro_desgradavel sim)))
	=>
	(assert (Praga (praga Fungo)))
	(printout t "Praga identificada! Fungos sao a causa." crlf))

; NEMATOIDE
(defrule IsNematoide(Planta (raizes_deformadas sim))
	=>
	(assert (Praga (praga Nematoide)))
	(printout t "Praga identificada! Nematoides sao a causa." crlf))

