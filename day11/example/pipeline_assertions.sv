module pipeline_assertions #(
    parameter int WIDTH = 8
) (
    input logic             clk,
    input logic             rst_n,

    input logic             valid_in,
    input logic [WIDTH-1:0] data_in,

    input logic             valid_out,
    input logic [WIDTH-1:0] data_out
);

    // ==========================================
    // 1. Input valid should arrive 3 cycles later
    // ==========================================

    property p_valid_latency;

        @(posedge clk)
        disable iff (!rst_n)

        valid_in |-> ##3 valid_out;

    endproperty

    assert property (p_valid_latency)
        else $error("valid_out did not arrive after 3 cycles");


    // ==========================================
    // 2. Data should arrive 3 cycles later
    // ==========================================

    property p_data_latency;

        @(posedge clk)
        disable iff (!rst_n)

        valid_in |-> ##3
        (valid_out && data_out == $past(data_in, 3));

    endproperty

    assert property (p_data_latency)
        else $error("Pipeline data mismatch");


    // ==========================================
    // 3. valid_out must not assert without input
    // ==========================================

    property p_no_spurious_output;

        @(posedge clk)
        disable iff (!rst_n)

        valid_out |-> $past(valid_in, 3);

    endproperty

    assert property (p_no_spurious_output)
        else $error("Spurious valid_out detected");


endmodule