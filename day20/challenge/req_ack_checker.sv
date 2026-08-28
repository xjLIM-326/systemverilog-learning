module req_ack_checker (
    input logic clk,
    input logic reset_n,

    input logic req,
    input logic ack
);

    // ------------------------------------------------
    // Sequence
    // ------------------------------------------------

    sequence ack_after_one_to_two_cycles;
        ##[1:2] ack;
    endsequence

    sequence req_fall_next_cycle;
        ##1 !req;
    endsequence


    // ------------------------------------------------
    // Property
    // ------------------------------------------------

    property req_ack_property;
        @(posedge clk) disable iff (!reset_n)
            req |-> ack_after_one_to_two_cycles;
    endproperty

    property req_pulse_property;
        @(posedge clk) disable iff (!reset_n)
            req |-> req_fall_next_cycle; 
    endproperty

    property valid_ack_timing_property;
        @(posedge clk) disable iff (!reset_n)
            ack |-> ($past(req) || $past(req, 2));
    endproperty


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    assert_req_ack:
        assert property (req_ack_property)
        else $error("REQ was not acknowledged within 2 cycles");

    assert_req_pulse:
        assert property (req_pulse_property)
        else $error("REQ was not a pulse");

    assert_ack_has_recent_req:
        assert property (valid_ack_timing_property)
        else $error("ACK was not preceded by REQ within 2 cycles");


endmodule