;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $052B
!OutAddr = $0200
!ProgAddr = $D800

!ReadIndex = $01

incsrc "asm/readV120.asm"