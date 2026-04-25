;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $6F64
!OutAddr = $0200
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVOcean.asm"