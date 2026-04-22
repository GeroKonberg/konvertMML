;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $3B00
!OutAddr = $8000
!ProgAddr = $F000

!ReadIndex = $7E

incsrc "asm/readV120.asm"