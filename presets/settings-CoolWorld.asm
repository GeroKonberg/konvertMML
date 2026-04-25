;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $1D6E
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVOcean.asm"