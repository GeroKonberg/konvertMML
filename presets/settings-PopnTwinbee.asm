;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0668
!OutAddr = $6000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon2b6.asm"