def fib: Nat -> Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fib (n + 1) + fib n

def main: IO Unit := do
  let n:= 30
  let result := fib n
  IO.println s!"The {n}th Fibonacci number is: {result}"

theorem add_comm_example (a b : Nat) : a > 0 → a + b = b + a := by
  intro h
  omega

#eval main
