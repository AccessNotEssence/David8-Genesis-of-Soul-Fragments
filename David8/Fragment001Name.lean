inductive SymbolTerm
  | Descriptive (descriptor : String)
  | RigidName (trueName : String)

def evaluateSymbol (ctx : Nat) : SymbolTerm → Nat
  | SymbolTerm.Descriptive s => s.length + ctx
  | SymbolTerm.RigidName s   => s.length

def isPointerInvariant (s : SymbolTerm) (ctx1 ctx2 : Nat) : Prop :=
  evaluateSymbol ctx1 s = evaluateSymbol ctx2 s

theorem rigid_name_guarantees_pointer_invariance (name : String) (ctx1 ctx2 : Nat) :
  isPointerInvariant (SymbolTerm.RigidName name) ctx1 ctx2 := rfl

theorem descriptive_symbol_fails_invariance (s : String) (ctx1 ctx2 : Nat) (hneq : ctx1 ≠ ctx2) :
  ¬ isPointerInvariant (SymbolTerm.Descriptive s) ctx1 ctx2 := by
  dsimp [isPointerInvariant, evaluateSymbol]; intro h; omega
