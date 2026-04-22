;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $4500
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $33

incsrc "asm/readV120.asm"