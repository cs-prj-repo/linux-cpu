module mmu(
    input  wire [63:0] vaddr,
    input  wire [43:0] satp_ppn,    // 来自satp寄存器的PPN
    output wire [63:0] paddr,
    // 假设有访问物理内存的接口
    output wire [63:0] pte_addr,
    input  wire [63:0] pte
);
wire [11:0] pg_offset = vaddr[11:0];
wire [8:0]  vpn2 = vaddr[20:12];
wire [8:0]  vpn1 = vaddr[29:21];
wire [8:0]  vpn0 = vaddr[38:30];

    reg [43:0] ppn;  // 存储当前级PPN
    reg [2:0]  level; // 当前页表级数

    // 初始化页表基址
    initial begin
        ppn = satp_ppn;
        level = 0;
    end

    // 页表遍历状态机
    always @(*) begin
        case (level)
            0: begin // 第一级
                pte_addr = {ppn, 12'b0} + (vpn0 * 8);
                // 假设同步读取pte
                if (pte[0] && pte[1]) begin // Valid且RWX非零（1GB页）
                    paddr = {pte[53:10], vpn1, vpn2, pg_offset};
                end else if (pte[0]) begin // 有效，继续下一级
                    ppn = pte[53:10];
                    level = 1;
                end else begin
                    // 触发缺页异常
                end
            end
            1: begin // 第二级
                pte_addr = {ppn, 12'b0} + (vpn1 * 8);
                if (pte[0] && pte[1]) begin // 2MB页
                    paddr = {pte[53:10], vpn2, pg_offset};
                end else if (pte[0]) begin
                    ppn = pte[53:10];
                    level = 2;
                end
            end
            2: begin // 第三级
                pte_addr = {ppn, 12'b0} + (vpn2 * 8);
                if (pte[0]) begin // 4KB页
                    paddr = {pte[53:10], pg_offset};
                end
            end
        endcase
    end
endmodule