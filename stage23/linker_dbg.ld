OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS
{
    . = 0x8000;

    .entry : {
        *(.entry)
    }

    .realmode : {
        *(.realmode)
    }

    .stage2.text : {
        *.s2.o(.text .text.*)
    }

    .stage2.build-id : {
        build_id_s2 = .;
        *build-id.s2.o(*)
    }

    .stage2.data : {
        *.s2.o(.no_unwind)
        s2_data_begin = .;
        *.s2.o(.data .data.*)
        s2_data_end = .;
        *.s2.o(.rodata .rodata.*)
        *(.stage2_map)
    }

    .stage3.text : {
        stage3_addr = .;
        *(.text .text.*)
    }

    .stage3.build-id : {
        build_id_s3 = .;
        *build-id.s3.o(*)
    }

    .stage3.data : {
        *(.rodata .rodata.*)
        *(.full_map)
        *(.no_unwind)
        data_begin = .;
        *(.data .data.*)
    }

    .note.gnu.build-id : {
        *(.note.gnu.build-id)
        limine_sys_size = . - 0x8000;
    }

    .bss : {
        bss_begin = .;
        *(COMMON)
        *(.bss .bss.*)
        bss_end = .;
        data_end = .;
    }

    .symtab 0 : {
        *(.symtab)
    }

    .strtab 0 : {
        *(.strtab)
    }

    .shstrtab 0 : {
        *(.shstrtab)
    }

    .debug_aranges 0 : {
        *(.debug_aranges)
    }

    .debug_pubnames 0 : {
        *(.debug_pubnames)
    }

    .debug_info 0 : {
        *(.debug_info)
    }

    .debug_abbrev 0 : {
        *(.debug_abbrev)
    }

    .debug_line 0 : {
        *(.debug_line)
    }

    .debug_loclists 0 : {
        *(.debug_loclists)
    }

    .debug_rnglists 0 : {
        *(.debug_rnglists)
    }

    .debug_frame 0 : {
        *(.debug_frame)
    }

    .debug_loc 0 : {
        *(.debug_loc)
    }

    .debug_ranges 0 : {
        *(.debug_ranges)
    }

    .debug_str 0 : {
        *(.debug_str)
    }

    .debug_line_str 0 : {
        *(.debug_line_str)
    }

    /DISCARD/ : {
        *(*)
    }
}
