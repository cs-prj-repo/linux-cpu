
#include <cpu.h>
#include <cstdint>
#include <simulator_state.h>
#include <common.h>
#include <defs.h>


void instr_trace(word_t pc, word_t instr) {
    // #define instr_max_size 100
    // word_t inst_pc = pc;
    // word_t inst_val = pmem_read(pc, 4);
    // char inst_str[instr_max_size];
    // disassemble(inst_str,instr_max_size, inst_pc, (uint8_t *)&inst_val, 8);
    // printf("处理器执行了[pc=0x%lx]处的指令[instr=0x%08lx]    %s\n", pc, inst_val, inst_str);

    #define instr_max_size 100
    char inst_str[instr_max_size];
    disassemble(inst_str,instr_max_size, pc, (uint8_t *)&instr, 8);
    printf("处理器执行了pc=[0x%lx]处的指令instr=[0x%08lx], 其反汇编=[%s]\n", pc, instr, inst_str);
}