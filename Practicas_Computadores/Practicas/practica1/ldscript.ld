SECTIONS
{

.data 0x0c000000: { *(.data)
*(.bss)
 }

.text : {
_btext = .;
*(.text)
_etext = .;
}



.stack 0x0c200000: {
__stack_base = .;
}

}
