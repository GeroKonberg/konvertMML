;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0491
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVBetop.asm"