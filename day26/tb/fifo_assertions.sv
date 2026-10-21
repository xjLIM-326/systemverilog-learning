module fifo_assertions (
    fifo_if vif
);

    // Confirm that the assertion checker is instantiated via bind.
    initial begin
        `uvm_info("SVA", $sformatf("fifo_assertions instantiated at %m"), UVM_NONE)
    end

    // P1: The FIFO must never be full and empty simultaneously.
    a_full_empty_mutex: assert property (
        @(posedge vif.clk)
        disable iff (!vif.rst_n)
        !(vif.full && vif.empty)
    )
    else $error("FIFO cannot be full and empty simultaneously.");

    // P2: The FIFO must remain empty and not full while reset is active.
    a_empty_during_reset: assert property (
        @(posedge vif.clk)
        !vif.rst_n |=> (!vif.full && vif.empty)
    )
    else $error("FIFO must be empty and not full while reset is active.");

    // P3: The FIFO must remain empty until a write request occurs.
    a_empty_until_write: assert property (
        @(posedge vif.clk)
        disable iff (!vif.rst_n)
        vif.empty |-> (vif.empty until_with (vif.wr_en && !vif.full))
    )
    else $error("FIFO must remain empty until a write is requested.");

    // P4: A write to an empty FIFO must deassert the empty flag.
    a_not_empty_after_write: assert property (
        @(posedge vif.clk)
        disable iff (!vif.rst_n)
        (vif.empty && vif.wr_en && !vif.full) |=> !vif.empty
    )
    else $error("FIFO empty flag must be deasserted after a write to an empty FIFO.");

    // P5: An accepted write must cause the FIFO to become non-empty.
    a_write_makes_fifo_nonempty: assert property (
        @(posedge vif.clk)
        disable iff (!vif.rst_n)
        (vif.wr_en && !vif.full) |=> !vif.empty
    )
    else $error("FIFO must become non-empty after an accepted write.");

    // P6: An accepted read must cause the FIFO to become non-full.
    a_read_makes_fifo_nonfull: assert property (
        @(posedge vif.clk)
        disable iff (!vif.rst_n)
        (vif.rd_en && !vif.empty) |=> !vif.full
    )
    else $error("FIFO must become non-full after an accepted read.");

    // P7: Simultaneous accepted read and write operations must preserve the FIFO status flags.
    a_read_write_same_status: assert property (
        @(posedge vif.clk)
        disable iff (!vif.rst_n)
        (vif.rd_en && !vif.empty && vif.wr_en && !vif.full) |=> ($stable(vif.full) && $stable(vif.empty))
    )
    else $error("FIFO full and empty flags must remain unchanged after simultaneous accepted read and write operations.");


endmodule
