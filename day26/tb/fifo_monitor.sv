class fifo_monitor #(parameter DATA_WIDTH = 8) extends uvm_monitor;

    virtual fifo_if vif;

    `uvm_component_param_utils(fifo_monitor #(DATA_WIDTH))

    uvm_analysis_port #(fifo_transaction #(DATA_WIDTH)) actual_port;

    covergroup fifo_cg with function sample(
        bit wr_en,
        bit rd_en,
        bit full_before,
        bit empty_before
    );

        cp_fifo_state: coverpoint {full_before, empty_before} {
            bins empty   = {2'b01};
            bins partial = {2'b00};
            bins full    = {2'b10};
            illegal_bins invalid = {2'b11};
        }

        cp_operation: coverpoint {wr_en, rd_en} {
            bins idle       = {2'b00};
            bins write_only = {2'b10};
            bins read_only  = {2'b01};
            bins read_write = {2'b11};
        }

        state_x_operation: cross cp_fifo_state, cp_operation;

    endgroup

    function new(string name = "fifo_monitor",
                 uvm_component parent = null);

        super.new(name, parent);
        fifo_cg = new();

    endfunction


    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        actual_port = new("actual_port", this);

    endfunction


    task run_phase(uvm_phase phase);

        fifo_transaction #(DATA_WIDTH) actual_txn ;

        forever begin

            // Wait for DUT pre-rising edge
            @(vif.mon_cb);

            actual_txn = fifo_transaction#(DATA_WIDTH)::type_id::create("actual_txn");

            actual_txn.rst_n = vif.mon_cb.rst_n;
            actual_txn.wr_en = vif.mon_cb.wr_en;
            actual_txn.rd_en = vif.mon_cb.rd_en;
            actual_txn.din = vif.mon_cb.din;

            // Sample FIFO state before operation for coverage
            if (actual_txn.rst_n) begin
                fifo_cg.sample(
                    vif.mon_cb.wr_en,
                    vif.mon_cb.rd_en,
                    vif.mon_cb.full,
                    vif.mon_cb.empty
                );
            end

            // Wait for DUT exact rising edge
            #1step;

            // Sample post-rising edge DUT outputs for scoreboard
            actual_txn.dout = vif.dout;
            actual_txn.full = vif.full;
            actual_txn.empty = vif.empty;

            // Publish actual_txn through actual_port
            actual_port.write(actual_txn);

            `uvm_info("MONITOR",
                $sformatf(
                    "rst_n=%0b wr=%0b rd=%0b din=%02h | dout=%02h full=%0b empty=%0b",
                    actual_txn.rst_n,
                    actual_txn.wr_en,
                    actual_txn.rd_en,
                    actual_txn.din,
                    actual_txn.dout,
                    actual_txn.full,
                    actual_txn.empty
                ),
                UVM_NONE
            )

        end

    endtask



    function void report_phase(uvm_phase phase);

        super.report_phase(phase);

        `uvm_info("COVERAGE", $sformatf("FIFO state = %0.2f%%", fifo_cg.cp_fifo_state.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Operation = %0.2f%%", fifo_cg.cp_operation.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("FIFO state x Operation = %0.2f%%", fifo_cg.state_x_operation.get_coverage()), UVM_NONE)

    endfunction

endclass
