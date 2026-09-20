module protocol_assertions (
    input  logic clk,
    input  logic reset_n,

    input  logic req,

    input logic grant,
    input logic busy,
    input logic done
);

    default clocking cb @(posedge clk);
    endclocking

    // ------------------------------------------------
    // Assertion 1
    // ------------------------------------------------
    //
    // If req is asserted, grant must be asserted within 2 clock cycles.
    //
    // ------------------------------------------------

    property req_then_grant;

        req |-> ##[1:2] grant;

    endproperty

    assert property (disable iff (!reset_n)
                     req_then_grant);


    // ------------------------------------------------
    // Assertion 2
    // ------------------------------------------------
    //
    // If grant is asserted, busy must be asserted simultaneously.
    //
    // ------------------------------------------------

    property grant_then_busy;

        grant |-> busy;

    endproperty

    assert property (disable iff (!reset_n)
                     grant_then_busy);


    // ------------------------------------------------
    // Assertion 3
    // ------------------------------------------------
    //
    // If busy is asserted, it must remain until done is asserted.
    //
    // ------------------------------------------------

    property busy_until_done;

        busy |-> busy until_with done;

    endproperty

    assert property (disable iff (!reset_n)
                     busy_until_done);


    // ------------------------------------------------
    // Assertion 4
    // ------------------------------------------------
    //
    // While busy is asserted, no request should be accepted.
    //
    // ------------------------------------------------

    property busy_no_req;

        busy |-> !req;

    endproperty

    assert property (disable iff (!reset_n)
                     busy_no_req);


    // ------------------------------------------------
    // Assertion 5
    // ------------------------------------------------
    //
    // If done falls, busy must be deasserted during next cycle.
    //
    // ------------------------------------------------

    property done_no_busy;

        done |=> !busy;

    endproperty

    assert property (disable iff (!reset_n)
                     done_no_busy);
endmodule