;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $099C
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon2a6.asm"