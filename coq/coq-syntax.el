;; coq-syntax.el Font lock expressions for Coq
;; Copyright (C) 1997, 1998 LFCS Edinburgh. 
;; Authors: Thomas Kleymann and Healfdene Goguen
;; Maintainer: Patrick Loiseleur <Patrick.Loiseleur@lri.fr> 

;; $Id$

(require 'proof-syntax)

;; ----- keywords for font-lock.

(defvar coq-keywords-decl
  '(
"Axiom[s]?"
"Hypotheses"
"Hypothesis"
"Parameter[s]?"
;; da: 3.2 I added Section here, to try to fix undo for Sections working
;; better.
;;Pierre : Chapter also
"Variable[s]?"
"Global\\s-+Variable"
;;added tactic def here because it needs Reset to be undone correctly
"Tactic\\s-+Definition"
))

(defvar coq-keywords-defn
  '(
"CoFixpoint"
"CoInductive"
"Fixpoint"
"Inductive"
"Inductive\\s-+Set"
"Inductive\\s-+Prop"
"Inductive\\s-+Type"
"Mutual\\s-+Inductive"
"Record"
"Scheme"
"Syntactic\\-+Definition"
"Structure"
))

(defvar coq-keywords-goal
  '(
"Chapter"
"Section"
"Correctness"
"Definition"
"Fact"
"Goal"
"Lemma"
"Local"
"Remark"
"Theorem"
))

(defvar coq-keywords-save
  '(
"Defined"
"Save"
"Qed"
"End"
))

(defvar coq-keywords-kill-goal '(
"Abort"
))




(defcustom coq-user-backable-commands nil
 
"Configuration variable (default to nil). List of strings containing
the user defined Coq commands that need to be backtracked (like
Require, Definition, etc).

For example if MyHint and MyRequire are user defined variants of the
Hint and Require commands, put the following line in your .emacs:

(setq coq-user-backable-commands 
		'(\"MyHint\" \"MyRequire\"))
"
)

(defvar coq-user-non-backable-commands nil
 
"Configuration variable (default to nil). List of strings containing
the user defined Coq commands that do not need to be backtracked (like
Print, Check, Show etc).

For example if MyPrint and MyCheck are user defined variants of the
Print and Check commands, put the following line in your .emacs:

(setq coq-user-non-backable-commands 
		'(\"MyPrint\" \"MyCheck\"))
"
)

;; 

(defvar coq-keywords-non-backable-commands
  (append '(
"(*" ;;Pierre comments must not be undone
"Add\\s-+LoadPath"
"Add\\s-+ML\\s-+Path"
"Add\\s-+Rec\\s-+ML\\s-+Path"
"Add\\s-+Rec\\s-+LoadPath"
"Cd"
"Check"
"DelPath"
"Eval"
"Extraction"
"Extraction Module"
"Focus" ;; ???
"Hint\\-+Rewrite"
"Inspect"
"Locate"
"Locate\\s-+File"
"Locate\\s-+Library"
"Opaque"
"Print"
"Proof"; also in non-undoable-tactic
"Recursive\\-+Extraction"
"Recursive\\-+Extraction\\-+Module"
"Remove\\-+LoadPath"
"Pwd"
"Qed"
"Reset"
"Save"
"Search"
"SearchIsos"
"SearchPattern"
"SearchRewrite"
"Show"
"Test\\s-+Printing\\s-+If"
"Test\\s-+Printing\\s-+Let"
"Test\\s-+Printing\\s-+Synth"
"Test\\s-+Printing\\s-+Wildcard"
"Unfocus" ; ???
"Transparent"
"Write\\s-+State")
			 coq-user-non-backable-commands
			 )
  )




(defvar coq-keywords-backable-misc-commands
 '(
"Add\\s-+Abstract\\s-+Ring"
"Add\\s-+Abstract\\s-+Semi\\s-+Ring"
"Add\\s-+Field"
"Add\\s-+Morphism"
"Add\\s-+Printing"
"Add\\s-+Ring"
"Add\\s-+Semi\\s-+Ring"
"Add\\s-+Setoid"
"Begin\\s-+Silent"
"Canonical\\s-+Structure"
"CoFixpoint"
"CoInductive"
"Coercion"
"Declare\\s-+ML\\s-+Module"
"End\\s-+Silent"
"Derive\\s-+Dependent\\s-+Inversion"
"Derive\\s-+Dependent\\s-+Inversion_clear"
"Derive\\s-+Inversion"
"Derive\\s-+Inversion_clear"
"Extract\\s-+Constant"
"Extract\\s-+Inductive"
"Extraction\\s-+Inline"
"Extraction\\s-+Language"
"Extraction\\s-+NoInline"
"Grammar"
"Hint"
"Hints"
"Identity\\s-+Coercion"
"Implicit\\s-+Arguments\\s-+Off"
"Implicit\\s-+Arguments\\s-+On"
"Implicits"
"Infix"
"Load"
"Read\\s-+Module"
"Remove\\s-+LoadPath"
"Remove\\s-+Printing\\s-+If\\s-+ident"
"Remove\\s-+Printing\\s-+Let\\s-+ident"
"Require"
"Require\\s-+Export"
"Reset\\s-+Extraction\\s-+Inline"
"Reset\\s-+Initial"
"Restart"
"Restore\\s-+State"
"Remove\\s-+Printing\\s-+If\\s-+ident"
"Remove\\s-+Printing\\s-+Let\\s-+ident"
"Restore\\s-+State"
"Set" ; wrong see below
"Unset" ; wrong
"Syntax"
"Transparent"
)
 )


;
;Set Hyps_limit  ------------> pour tous les Set/Unset, fais un
;Set Implicit Arguments        "Print Tables" ; les synchroneous sont
;Set Undo                      les backable
;Set Extraction AutoInline
;Set Extraction Optimize
;Set Printing Coercion
;Set Printing Coercions
;Set Printing Synth
;Set Printing Wildcard
;Unset Extraction AutoInline
;Unset Extraction Optimize
;Unset Hyps_limit
;Unset Implicit Arguments
;Unset Printing Coercion
;Unset Printing Coercions
;Unset Printing Synth
;Unset Printing Wildcard
;Unset Undo
;


(defvar coq-keywords-backable-commands
  (append
	coq-keywords-backable-misc-commands
	coq-keywords-decl
	coq-keywords-defn
	coq-keywords-goal
	coq-user-backable-commands
	)
  )

(defvar coq-keywords-commands
  (append coq-keywords-backable-commands
			 coq-keywords-non-backable-commands)
  "All commands keyword")


(defcustom coq-user-undoable-tactics nil
 
"Configuration variable (default to nil). List of strings containing
the user defined Coq tactics that need to be backtracked (like almost
all tactics, but \"Proof\").

For example if MyIntro and MyElim are user defined variants of the
Intro and Elim tactics, put the following line in your .emacs:

(setq coq-user-undoable-tactics
		'(\"MyIntro\" \"MyElim\"))
"
)

(defvar coq-undoable-tactics
 (append  '(
"Absurd"
"Apply"
"Assert"
"Assumption"
"Auto"
"AutoRewrite"
"Case"
"Cbv"
"Change"
"Clear"
"ClearBody"
"Cofix"
"Compare"
"Compute"
"Constructor"
"Contradiction"
"Cut"
"CutRewrite"
;"DHyp"
;"DInd"
"Decide Equality"
"Decompose"
"Dependent Inversion"
"Dependent Inversion_clear"
"Dependent Rewrite ->"
"Dependent Rewrite <-"
"Dependent\\s-+Inversion"
"Dependent\\s-+Inversion_clear"
"Destruct"
"DiscrR"
"Discriminate"
"Double\\-+Induction"
"EApply"
"EAuto"
"Elim"
"ElimType"
"Exact"
"Exists"
"Field"
"Fix"
"Fold"
"Fourier"
"Generalize"
"Hnf"
"Induction"
"Injection"
"Intro[s]?"
"Intuition"
"Inversion"
"Inversion_clear"
"LApply"
"Lazy"
"Left"
"LetTac"
"Linear"
"Load"
"Move"
"NewDestruct"
"NewInduction"
"Omega "
"Pattern"
"Pose"
"Program"
"Program_all"
"Prolog"
"Quote"
"Realizer"
"Red"
"Refine"
"Reflexivity"
"Rename"
"Replace"
"Rewrite"
"Right"
"Ring"
"Setoid_replace"
"Simpl"
"Simple Inversion"
"Simplify_eq"
"Specialize"
"Split"
"SplitAbsolu"
"SplitRmult"
"Symmetry"
"Tauto"
"Transitivity"
"Trivial"
"Unfold"
)
coq-user-undoable-tactics
)

)

(defcustom coq-user-non-undoable-tactics nil
 
"Configuration variable (default to nil). List of strings containing
the user defined Coq tactics that do not need to be backtracked (like
\"Proof\" (no other one to my knowledge ?)).

For example if MyProof and Do_nthing are user defined variants of the
Proof (Nop) tactic, put the following line in your .emacs:

(setq coq-user-non-undoable-tactics
		'(\"MyProof\" \"Do_nthing\"))
"
)

(defvar coq-non-undoable-tactics 
  (append '(
"Proof" ; also in non-backable-command
"Idtac"
)
			 coq-user-non-undoable-tactics
)
)

(defvar coq-tactics 
  (append coq-undoable-tactics coq-non-undoable-tactics))


(defvar coq-retractable-instruct
  (append coq-undoable-tactics coq-keywords-backable-commands)
  )

(defvar coq-non-retractable-instruct
  (append coq-non-undoable-tactics
			 coq-keywords-non-backable-commands)
  )

(defvar coq-keywords
  (append coq-keywords-goal coq-keywords-save coq-keywords-decl
	  coq-keywords-defn coq-keywords-commands)
  "All keywords in a Coq script")

(defvar coq-tacticals 
  '(
    "Abstract"
    "Do"
    "Idtac" ; also in  non-undoable-tactic
    "Orelse"
    "Repeat"
    "Try")
  "Keywords for tacticals in a Coq script")

(defvar coq-reserved
  '(
    "as"
    "ALL"
    "Cases"
    "EX"
    "else"
    "end"
    "Fix"
    "if"
    "in"
	 "into"
    "let"
    "of"
    "then"
    "using"
    "with"
    )
  "Reserved keyworkds of Coq")

(defvar coq-symbols
  '(
    "|"
    ":"
    ";"
    ","
    "("
    ")"
    "["
    "]"
    "{"
    "}"
    ":="
    "=>"
    "->"
    "."
    )
  "Punctuation Symbols used by Coq")

;; ----- regular expressions
(defvar coq-error-regexp "^\\(Error\\|Discarding\\|Syntax error\\|System Error\\|Anomaly\\|Uncaught exception\\|Toplevel input\\)"
  "A regular expression indicating that the Coq process has identified
  an error.")

(defvar coq-id proof-id)

(defvar coq-ids (proof-ids coq-id))

(defun coq-first-abstr-regexp (paren)
  (concat paren "\\s-*\\(" coq-ids "\\)\\s-*:"))

(defun coq-next-abstr-regexp ()
  (concat ";[ \t]*\\(" coq-ids "\\)\\s-*:"))

(defvar coq-font-lock-terms
  (list

   ;; lambda binders
   (list (coq-first-abstr-regexp "\\[") 1 'proof-declaration-name-face)

   ;; Pi binders
   (list (coq-first-abstr-regexp "(") 1 'proof-declaration-name-face)
   
   ;; second, third, etc. abstraction for Lambda of Pi binders
   (list (coq-next-abstr-regexp) 1 'proof-declaration-name-face)

   ;; Kinds
   (cons "\\<Prop\\>\\|\\<Set\\>\\|\\<Type\\>" 'font-lock-type-face))

  "*Font-lock table for Coq terms.")

;; According to Coq, "Definition" is both a declaration and a goal.
;; It is understood here as being a goal.  This is important for
;; recognizing global identifiers, see coq-global-p.
(defconst coq-save-command-regexp
  (proof-anchor-regexp (proof-ids-to-regexp coq-keywords-save)))
(defconst coq-save-with-hole-regexp
  (concat "\\(" (proof-ids-to-regexp coq-keywords-save)
	  "\\)\\s-+\\(" coq-id "\\)\\s-*\."))
(defconst coq-goal-command-regexp
  (proof-anchor-regexp (proof-ids-to-regexp coq-keywords-goal)))
(defconst coq-goal-with-hole-regexp
  (concat "\\(" (proof-ids-to-regexp coq-keywords-goal)
	  "\\)\\s-+\\(" coq-id "\\)\\s-*[:]?")) 
          ;; Papageno : ce serait plus propre d'omettre le `:' 
          ;; uniquement pour Correctness
          ;; et pour Definition f [x,y:nat] := body
(defconst coq-decl-with-hole-regexp
  (concat "\\(" (proof-ids-to-regexp coq-keywords-decl)
	  "\\)\\s-+\\(" coq-ids "\\)\\s-*[:]"))
(defconst coq-defn-with-hole-regexp
  (concat "\\(" (proof-ids-to-regexp coq-keywords-defn)
	  "\\)\\s-+\\(" coq-id "\\)\\s-*[:]"))

(defvar coq-font-lock-keywords-1
   (append
    coq-font-lock-terms
    (list
     (cons (proof-ids-to-regexp coq-keywords) 'font-lock-keyword-face)
     (cons (proof-ids-to-regexp coq-tactics) 'proof-tactics-name-face)
     (cons (proof-ids-to-regexp coq-tacticals) 'proof-tacticals-name-face)
     (cons (proof-ids-to-regexp coq-reserved) 'font-lock-type-face)
     (cons "============================" 'font-lock-keyword-face)
     (cons "Subtree proved!" 'font-lock-keyword-face)
     (cons "subgoal [0-9]+ is:" 'font-lock-keyword-face)
     (list "^\\([^ \n]+\\) \\(is defined\\)" 
	   (list 2 'font-lock-keyword-face t)
	   (list 1 'font-lock-function-name-face t))

     (list coq-goal-with-hole-regexp 2 'font-lock-function-name-face)
     (list coq-decl-with-hole-regexp 2 'proof-declaration-name-face)
     (list coq-defn-with-hole-regexp 2 'font-lock-function-name-face)
     (list coq-save-with-hole-regexp 2 'font-lock-function-name-face))))

(defun coq-init-syntax-table ()
  "Set appropriate values for syntax table in current buffer."

  (modify-syntax-entry ?\$ ".")
  (modify-syntax-entry ?\/ ".")
  (modify-syntax-entry ?\\ ".")
  (modify-syntax-entry ?+  ".")
  (modify-syntax-entry ?-  ".")
  (modify-syntax-entry ?=  ".")
  (modify-syntax-entry ?%  ".")
  (modify-syntax-entry ?<  ".")
  (modify-syntax-entry ?>  ".")
  (modify-syntax-entry ?\& ".")
  (modify-syntax-entry ?_  "w")
  (modify-syntax-entry ?\' "_")
  (modify-syntax-entry ?\| ".")
  (modify-syntax-entry ?\* ". 23")
  (modify-syntax-entry ?\( "()1")
  (modify-syntax-entry ?\) ")(4"))

(provide 'coq-syntax)
