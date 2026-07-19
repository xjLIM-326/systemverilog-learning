module handshake_assertions (
    input logic       clk,
    input logic       rst_n,

    input logic       valid,
    input logic [7:0] data,

    input logic       ready,
    input logic       accepted
);

   property p_accept_only_on_handshake;
        @(posedge clk)
        disable iff (!rst_n)
        accepted |-> $past(valid && ready);
    endproperty

    assert property (p_accept_only_on_handshake)
        else $error("BUG: Data accepted without proper handshake");


    property p_busy_after_accept;
        @(posedge clk)
        disable iff (!rst_n)
        accepted |=> !ready;
    endproperty

    assert property (p_busy_after_accept)
        else $error("BUG: Consumer remains ready after accepting data");


    property p_accepted_one_cycle_pulse;
        @(posedge clk)
        disable iff (!rst_n)
        accepted |=> !accepted;
    endproperty

    assert property (p_accepted_one_cycle_pulse)
        else $error("BUG: accepted remained high for multiple cycles");


    property p_valid_hold;
        @(posedge clk)
        disable iff (!rst_n)
        valid && !ready |=> valid;
    endproperty

    assert property (p_valid_hold)
        else $error("ILLEGAL: Valid changed before accepted");


    property p_data_hold;
        @(posedge clk)
        disable iff (!rst_n)
        valid && !ready |=> $stable(data);
    endproperty

    assert property (p_data_hold)
        else $error("ILLEGAL: Data changed before accepted");

endmodule