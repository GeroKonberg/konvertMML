;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $4A90
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVOcean.asm"