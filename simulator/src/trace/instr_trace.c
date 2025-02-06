
#include <cpu.h>
#include <cstdint>
#include <simulator_state.h>
#include <common.h>
#include <defs.h>


#define instr_max_size 100
void instr_trace(word_t pc) {
    word_t inst_pc = pc;
    word_t inst_val = pmem_read(pc, 4);

    char inst_str[instr_max_size];
    disassemble(inst_str,instr_max_size, inst_pc,(uint8_t*)inst_val, 8);
    printf("%s\n",inst_str);
}