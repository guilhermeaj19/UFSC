module Fila (Fila (Queue), emptyQueue, push, pop, top) where

data Fila t = Queue [t]
    deriving (Eq,Show)
    
push :: Fila t -> t -> Fila t
push (Queue s) x = Queue (x:s)

pop :: Fila t -> Fila t
pop (Queue []) = error "Empty"
pop (Queue (x:s)) = Queue s

top :: Fila t -> t
top (Queue []) = error "Empty"
top (Queue (x:s)) = x

emptyQueue :: Fila t
emptyQueue = Queue []