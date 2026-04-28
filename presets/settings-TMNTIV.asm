;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $11BE
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon1.asm"