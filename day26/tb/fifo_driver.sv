class fifo_driver #(parameter DATA_WIDTH = 8) extends uvm_driver #(fifo_transaction #(DATA_WIDTH));

    virtual fifo_if vif;

    `uvm_component_param_utils(fifo_driver #(DATA_WIDTH))

    uvm_analysis_port #(fifo_transaction #(DATA_WIDTH)) input_port;

    function new(string name = "fifo_driver",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        input_port = new("input_port", this);

    endfunction

    task run_phase(uvm_phase phase);

        fifo_transaction #(DATA_WIDTH) req;

        forever begin

            seq_item_port.get_next_item(req);

            // Drive req to DUT
            @(vif.drv_cb) begin
                vif.drv_cb.rst_n <= req.rst_n;
                vif.drv_cb.wr_en <= req.wr_en;
                vif.drv_cb.rd_en <= req.rd_en;
                vif.drv_cb.din <= req.din;

                // Publish req through input_port
                input_port.write(req);
            end

            seq_item_port.item_done();

        end

    endtask

endclass
